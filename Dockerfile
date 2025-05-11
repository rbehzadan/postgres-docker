# First stage: Build extensions
FROM postgres:17.5 AS builder

# Install required packages for building PostgreSQL extensions
RUN apt update && apt install -y \
    build-essential \
    clang \
    bison \
    flex \
    llvm \
    git \
    curl \
    libreadline-dev \
    zlib1g-dev \
    postgresql-server-dev-17 \
    libpq-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Rust and Cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && export PATH="$HOME/.cargo/bin:$PATH"

# Install specific version of pgrx
RUN export PATH="$HOME/.cargo/bin:$PATH" \
    && cargo install cargo-pgrx --version=0.14.1 \
    && cargo pgrx init --pg17 /usr/bin/pg_config

# Build pg_parquet
RUN git clone --depth 1 https://github.com/CrunchyData/pg_parquet.git /tmp/pg_parquet \
    && cd /tmp/pg_parquet \
    && export PATH="$HOME/.cargo/bin:$PATH" \
    && cargo pgrx install --release \
    && rm -rf /tmp/pg_parquet

# Copy files
RUN mkdir -p /artifacts/extension \
    && mkdir -p /artifacts/lib \
    && cp /usr/share/postgresql/17/extension/pg_parquet* /artifacts/extension/ \
    && cp /usr/lib/postgresql/17/lib/libpgcommon.a /artifacts/lib/ \
    && cp /usr/lib/postgresql/17/lib/libpgcommon_shlib.a /artifacts/lib/ \
    && cp /usr/lib/postgresql/17/lib/libpgfeutils.a /artifacts/lib/ \
    && cp /usr/lib/postgresql/17/lib/libpgport.a /artifacts/lib/ \
    && cp /usr/lib/postgresql/17/lib/libpgport_shlib.a /artifacts/lib/ \
    && cp /usr/lib/postgresql/17/lib/pg_parquet.so /artifacts/lib/


# Second stage: Final PostgreSQL image
FROM postgres:17.5

RUN apt update && apt install -y \
    postgresql-17-age \
    postgresql-17-cron \
    postgresql-17-jsquery \
    postgresql-17-partman \
    postgresql-17-pg-hint-plan \
    postgresql-17-pgaudit \
    postgresql-17-pgauditlogtofile \
    postgresql-17-pgpcre \
    postgresql-17-pgq3 \
    postgresql-17-pgrouting \
    postgresql-17-pgrouting-scripts \
    postgresql-17-pgsphere \
    postgresql-17-pgvector \
    postgresql-17-pllua \
    postgresql-17-postgis-3 \
    postgresql-17-postgis-3-scripts \
    postgresql-17-prefix \
    postgresql-17-timescaledb \
    && apt clean -y && apt autoremove -y && rm -rf /var/lib/apt/lists/*

# Copy built extensions from builder stage
COPY --from=builder /artifacts/lib/* /usr/lib/postgresql/17/lib/
COPY --from=builder /artifacts/extension/* /usr/share/postgresql/17/extension/

# Add health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD pg_isready -U postgres || exit 1

# Set default command
CMD ["postgres"]
