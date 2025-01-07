# Codepush Docker Setup

1. Create the following folders:

```
./bundles
./config
./mysql
```
2. Prepare a `.env` file

```
SERVER_CONFIG=<local|production>
REDIS_PORT=6379
MYSQL_PORT=3306
DOCKER_PORT=8080
DB_NAME=<codepush>
DB_USER=<username>
DB_PASSWORD=<password>
DB_ROOT_PASSWORD=<password>
```

3. Add configuration file to the config folder. The name should be `app.<SERVER_CONFIG>.json` in format. You can have multiple configs and change the `SERVER_CONFIG` environment variable to swap.
  - See https://github.com/htdcx/code-push-server-go for configuration details
4. Run `docker-compose build` (perhaps include `--no-cache` when changing environment configurations)
5. Run the container: `docker-compose up` (or via the docker daemon)

# First time setting up

You will need to import a database. At the https://github.com/htdcx/code-push-server-go repository, there is a `code-push.sql`. After running the server for the first time, connect to your database and run the queries in that file. **Important**: The sql dump tries to create a `code-push` database, you should change this to reflect your local database name.