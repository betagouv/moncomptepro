# MonComptePro - Installation Guide

This guide provides steps to run the MonComptePro Node.js application locally while managing its dependencies in Docker containers.

## Prerequisites

- Node.js (v20) installed locally (we suggest the usage of [nvm](https://github.com/nvm-sh/nvm))
- Docker (>= v25) and Docker Compose (>= v2.24) installed ([doc](https://docs.docker.com/engine/install/))
- Clone the MonComptePro repository

## Setting Up Dependencies with Docker

1. **Start Dependencies**: Navigate to the root directory of the cloned repository and run:

   ```bash
   docker compose up
   ```

   This will start all required services (e.g., databases) defined in the `docker-compose.yml`.

## Setting Up the Node.js Application

1. **Install Node.js Dependencies**:

   > If you don’t want to run end-to-end tests locally, you can prevent the installation script to download the (somewhat big) cypress binary by running `CYPRESS_INSTALL_BINARY=0 npm install` instead of the following command.

   Inside the project’s root directory, run:

   ```bash
   npm install
   ```

2. **Create a local version of dotenv file**: Inside the project's root directory, run:

   ```bash
   cp .env.sample .env
   ```

   This will create a local copy of the .env file containing the environnement variables to run MonComptePro.

3. **Get your own INSEE api credential**: or use the one of your teammates.

   Fetch them at https://api.gouv.fr/les-api/sirene_v3.

   Then fill your local .env file with them.

4. **Database Initialization**: The database will be automatically initialized with data from `scripts/fixtures.sql`.

   ```bash
   npm run fixtures:load
   ```

## Running the Application

After setting up the application, start the Node.js server with:

```bash
npm run dev
```

The application is now available at http://localhost:3000.

To log in, use the email address user@yopmail.com and the password "user@yopmail.com".

Emails are not sent but printed in the console.

## Testing the Connection with a Test Client

MonComptePro is provided with a test client: https://github.com/betagouv/moncomptepro-test-client

This container is launched within the MonComptePro `docker-compose.yml`.

It's available at http://localhost:3001
