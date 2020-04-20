# Intricately API

This project is a Ruby on Rails API for DNS/Hostnames search.

The project enables two endpoints to store / retrieve dns/hostnames data using [PostgreSQL](https://www.postgresql.org/) as database

### Endpoint POST([http://localhost:3000/dns_records](http://localhost:3000/dns_records))

```bash
curl --include --request POST http://localhost:3000/dns_records \
  --header "Content-Type: application/json" \
  --data '{
          "dns_record": {
            "ip_address": "1.1.1.1",
            "hostnames_attributes": [
              { "name": "lorem.com" },
              { "name": "ipsum.com" },
              { "name": "dolor.com" },
              { "name": "amet.com" }
            ]
          }
        }'
```

### Endpoint GET([http://localhost:3000/dns_records](http://localhost:3000/dns_records))

## Retrive records from page 1

```bash
curl --include --request GET http://localhost:3000/dns_records\?page\=1 \
  --header "Content-Type: application/json"
```

## Getting Started

There are two ways to run this project: with [Docker](https://www.docker.com/products/docker-desktop) or local.

## Running Local

```
Ruby version: 2.6.3
Rails version: 5.2.4
```

If you run this project local, you need to change `config/database.yml` file, setting your own database configuration.

Example:
```yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: localhost
  user: postgres
  password: your_db_pass
  port: 5432
```

After changes on `database.yml`, you may run the script command `sh start.sh` on the root project directory. This script file has all setup needed to install dependencies, create database ,run migrations, tests and also download and import locodes to database.

## Running with docker

This project has a Dockerfile and docker-compose file to build all environment with two simple commands:

`$ docker-compose build`

`$ docker-compose up`

The start.sh script, will execute all necessary setup to start the application, including rubocop and rspec:



## Running the tests manually

If you would like to run tests manually, in a local installation, just run in your terminal (root project directory):

```
$ bundle exec rails rspec
```
A test coverage report will appear on the end.

```
Coverage report generated for RSpec to /app/coverage. 105 / 105 LOC (100.0%) covered.
```