// ***********************************************************
// This example support/index.js is processed and
// loaded automatically before your test files.
//
// This is a great place to put global configuration and
// behavior that modifies Cypress.
//
// You can change the location of this file or turn off
// automatically serving support files with the
// 'supportFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/configuration
// ***********************************************************

// Import commands.js using ES2015 syntax:
import "cypress-mailslurp";
import "cypress-axe";
import { checkA11y } from "./a11y/checkA11y";

//

Cypress.Commands.overwrite("checkA11y", checkA11y);

Cypress.Commands.add("login", (email, password) => {
  cy.session([email, password], () => {
    // Visit the signup page
    cy.visit(`http://app.moncomptepro.localhost/users/start-sign-in`);

    // Sign in with the existing inbox
    cy.get('[name="login"]').type(email);
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type(password);
    cy.get('[action="/users/sign-in"]  [type="submit"]')
      .contains("S’identifier")
      .click();
  });
});

Cypress.Commands.add("seed", (dirname) => {
  const env = { SEED_DIR: dirname };
  const args = {
    compose: [`--project-directory ${dirname}`].join(" "),
    up: ["--build", "--detach"].join(" "),
  };

  const command = `docker compose ${args.compose} ps --services --filter "status=running"`;
  cy.task("log", `$ ${command}`);
  cy.exec(command).then((result) => {
    if (result.stdout.includes("moncomptepro")) {
      return;
    }

    {
      const command = `docker compose ${args.compose} up ${args.up}`;
      cy.task("log", `$ ${command}`);
      cy.exec(command, {
        env,
      }).then((result) => cy.task("log", result.stdout));
    }
  });

  {
    const command = `curl ${[
      "--fail",
      "--location",
      "--no-progress-meter",
      "--output /dev/null",
      "--retry 5",
      "--retry-all-errors",
      "--show-error",
    ].join(" ")} http://app.moncomptepro.localhost`;
    cy.task("log", `$ ${command}`);
    cy.exec(command, {
      env,
    }).then((result) => cy.task("log", result.stdout));
  }
});
