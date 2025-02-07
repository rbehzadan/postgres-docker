# PostgreSQL 17.2 with Extensions

This repository provides a Docker image for **PostgreSQL 17.2** with several useful extensions pre-installed. The image is built in two stages:  
1. **Building PostgreSQL Extensions** (such as `pg_parquet` from CrunchyData).  
2. **Final PostgreSQL Image** with the compiled extensions and additional PostgreSQL packages.

## Features

- Based on **PostgreSQL 17.2**
- Pre-installed PostgreSQL extensions:
  - [`pg_parquet`](https://github.com/CrunchyData/pg_parquet) (built from source)
  - `postgresql-17-age`
  - `postgresql-17-cron`
  - `postgresql-17-jsquery`
  - `postgresql-17-partman`
  - `postgresql-17-pg-hint-plan`
  - `postgresql-17-pgaudit`
  - `postgresql-17-pgauditlogtofile`
  - `postgresql-17-pgextwlist`
  - `postgresql-17-pgpcre`
  - `postgresql-17-pgq3`
  - `postgresql-17-pgrouting`
  - `postgresql-17-pgrouting-scripts`
  - `postgresql-17-pgsphere`
  - `postgresql-17-pgvector`
  - `postgresql-17-pllua`
  - `postgresql-17-postgis-3`
  - `postgresql-17-postgis-3-scripts`
  - `postgresql-17-powa`
  - `postgresql-17-prefix`
  - `postgresql-17-timescaledb`
  - `postgresql-17-unit`
- **Rust-based extension support** using [`pgrx`](https://github.com/pgcentralfoundation/pgrx).
- **Built-in health check** (`pg_isready`).

## Usage

### Pull the Image (if published)
```sh
docker pull rbehzadan/postgresql:17.2
```

### Build the Image Locally
If you want to build the image manually, clone this repository and run:
```sh
docker build -t my-postgres:17.2 .
```

### Run the Container
To start a PostgreSQL container using this image:
```sh
docker run -d --name postgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  rbehzadan/postgres:17.2
```

### Connecting to the Database
Using `psql`:
```sh
docker exec -it postgres psql -U admin -d mydb
```

### Enabling Extensions in PostgreSQL
After connecting to the database, enable any installed extension as follows:
```sql
CREATE EXTENSION pg_parquet;
CREATE EXTENSION postgis;
CREATE EXTENSION timescaledb;
```

## Health Check
The container includes a **health check** to ensure PostgreSQL is running correctly:
```sh
docker inspect --format='{{json .State.Health}}' postgres
```

## Contributing
If you find a bug, want to add a new extension, or optimize the build process, feel free to create an issue or submit a pull request.

## License
This project is licensed under the **MIT License**.
