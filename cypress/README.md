# End-to-End Testing with Cypress

> This guide provides steps to run end-to-end tests for the MonComptePro application using Cypress.

Cypress is using docker com

## Prerequisites

- Node.js (v20) installed locally
- Docker (>= v25) and Docker Compose (>= v2.24) installed
- https://mailslurp.com/ API token

```sh
$ export CYPRESS_MAILSLURP_API_KEY=__my_secret_token__
```

## Installation

```sh
$ npm ci
```

## Structure

Each test case has its own folder with a similar structure :

```sh
$ cypress
├── docker-compose.yml
├── e2e
│   ├── join_collectivite_territoriale_official_contact_domain
│   │   ├── docker-compose.yml
│   │   ├── join_collectivite_territoriale_official_contact_domain.conf
│   │   ├── join_collectivite_territoriale_official_contact_domain.cy.js
│   │   └── join_collectivite_territoriale_official_contact_domain.sql
```

1. `docker-compose.yml`: the docker compose configuration of the e2e case.
1. `<my_dot_file>.conf`: the moncomptepro environment file.
1. `<my_cypress_test_case>.cy.js`: the cypress test to run.
1. `<my_cypress_test_case>.sql`: the Postgres seed to populate the database.

## Warm up phase

Before running the end-to-end tests, you migh want to warm up your system.
We will be using the [cypress/e2e/reset_password](e2e/reset_password) test case as example.

1. **Pull the neccessary images**: Ensure you have the latest Docker images for the services defined in your docker-compose.yml file within the cypress/e2e/reset_password directory. Run the following command:

```sh
$ docker compose --project-directory cypress/e2e/reset_password pull

```

1. **Build the Docker images**: Build the Docker images for your moncomptepro service. This ensures that any changes you've made to your Dockerfiles are incorporated into the images. Run the following command:

```sh
$ docker compose --project-directory cypress/e2e/reset_password build moncomptepro
```

1. **Start the services**: Verify that the migration script seed the database

```sh
$ docker compose --project-directory cypress/e2e/reset_password up --build --detach
```

## Default configuration

By default, the test will be using `http://*.localhost` domains to provided by traefik. For example, you will find :

- **MonComptePro**: http://app.moncomptepro.localhost
- **Standard Client**: http://moncomptepro-standard-client.localhost (in [signin_from_standard_client](e2e/signin_from_standard_client/docker-compose.yml) test case)
- etc...

Consult the `docker-compose.yml` services label for more endpoints or the Traefik instance on http://monitor.localhost.

## Running the Tests

1. **Run All Tests**: You can run all of your Cypress tests from the command line with the following command:

```sh
$ npx cypress run
```

1. **Run a specific test**: You can run all of your Cypress tests from the command line with the following command:

```sh
$ npx cypress run --spec cypress/e2e/__case___/__test__.cy.js
# Example:
# npx cypress run --spec cypress/e2e/join_collectivite_territoriale_official_contact_domain/index.cy.js
# Or
$ npx cypress run --headed --spec cypress/e2e/__case___/__test__.cy.js
```

1. **Open Cypress Test Runner**: You can open the Cypress Test Runner, which allows you to run testing files individually and see their output, with the following command:

```sh
$ npx cypress open
```
