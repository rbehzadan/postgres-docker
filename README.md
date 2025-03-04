# PostgreSQL for Data Science & AI Workloads

This repository provides a **Docker image** for **PostgreSQL**, pre-configured with powerful extensions tailored for **data science, analytics, and AI/ML workloads**.  
The image is built in two stages:
1. **Building PostgreSQL Extensions** (e.g., `pg_parquet` from CrunchyData).  
2. **Final PostgreSQL Image** with compiled extensions and additional PostgreSQL packages.

---

## 🚀 Why Use This Image?

PostgreSQL is a **powerful data processing engine**, and with the right extensions, it can serve as a **feature store for AI/ML models, an analytics database, and a scalable data warehouse**.  
This image includes:

- **Vector search** for AI applications (**`pgvector`**)  
- **Time-series analysis** for real-time data (**`TimescaleDB`**)  
- **Efficient JSON querying** for structured/unstructured data (**`jsquery`**)  
- **Partitioning for large datasets** (**`pg_partman`**)  
- **Query optimization & hinting** (**`pg-hint-plan`**)  
- **Advanced auditing** for compliance/security (**`pgaudit`**)  
- **Job scheduling inside PostgreSQL** (**`pg_cron`**)  
- **Graph database support** for network analysis (**`AGE`**)  
- **Event queueing system** for real-time data streaming (**`pgq3`**)  
- **Advanced regex support** with Perl-compatible regex (**`pgpcre`**)  
- **Built-in Parquet file format support** (**`pg_parquet`**)  
  ⚠️ *Note: Building `pg_parquet` is resource-intensive and may take a long time.*

---

## 📦 Features & Pre-installed Extensions

- **PostgreSQL**
- **Optimized for AI, data science, and analytics**
- **Pre-installed PostgreSQL extensions:**
  - [`pg_parquet`](https://github.com/CrunchyData/pg_parquet) *(Parquet file format support)*
  - `postgresql-17-age` *(Graph database support)*
  - `postgresql-17-cron` *(Job scheduling within PostgreSQL)*
  - `postgresql-17-jsquery` *(Advanced JSON querying)*
  - `postgresql-17-partman` *(Automated table partitioning)*
  - `postgresql-17-pg-hint-plan` *(Query optimizer hints)*
  - `postgresql-17-pgaudit` & `postgresql-17-pgauditlogtofile` *(Audit logging)*
  - `postgresql-17-pgpcre` *(Perl-compatible regular expressions)*
  - `postgresql-17-pgq3` *(Queueing system for PostgreSQL)*
  - `postgresql-17-pgvector` *(Vector search for AI/ML workloads)*
  - `postgresql-17-prefix` *(Prefix search optimization)*
  - `postgresql-17-timescaledb` *(Time-series database functionality)*
- **Supports Rust-based PostgreSQL extensions** via [`pgrx`](https://github.com/pgcentralfoundation/pgrx).
- **Built-in health check** (`pg_isready`).

---

## 🏗️ Building the Image

### Pull from Docker Hub
```sh
docker pull rbehzadan/postgres
```

### Build Locally
To manually build the image:
```sh
docker build -t my-postgres .
```

⚠️ **Note:** Building `pg_parquet` requires significant CPU and memory resources, as it compiles from source.

---

## 📦 Running the Container

Start a PostgreSQL container with this image:
```sh
docker run -d --name postgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  rbehzadan/postgres
```

Connect to the database using `psql`:
```sh
docker exec -it postgres psql -U admin -d mydb
```

---

## 🛠️ Enabling Extensions

Once connected, enable any installed extension:
```sql
CREATE EXTENSION pg_parquet;
CREATE EXTENSION timescaledb;
CREATE EXTENSION pgvector;
CREATE EXTENSION age;
CREATE EXTENSION pgq3;
CREATE EXTENSION pgpcre;
```

---

## 🔍 Health Check

Verify the container's health status:
```sh
docker inspect --format='{{json .State.Health}}' postgres
```

---

## 🤝 Contributing

If you find a bug, want to add an extension, or improve the build process, feel free to **open an issue** or **submit a pull request**.

---

## 📜 License

This project is licensed under the **MIT License**.
