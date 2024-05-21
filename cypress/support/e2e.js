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
    cy.visit(`/users/start-sign-in`);

    // Sign in with the existing inbox
    cy.get('[name="login"]').type(email);
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type(password);
    cy.get('[action="/users/sign-in"]  [type="submit"]')
      .contains("S’identifier")
      .click();
  });
});

const RECORD = Cypress.env("RECORD") === true;

if (RECORD) {
  for (const command of [
    "visit",
    "click",
    "trigger",
    "type",
    "clear",
    "reload",
  ]) {
    Cypress.Commands.overwrite(command, (originalFn, ...args) => {
      const origVal = originalFn(...args);

      return new Promise((resolve) => {
        setTimeout(
          () => {
            resolve(origVal);
          },
          RECORD ? 2000 : 0,
        );
      });
    });
  }
  Cypress.config("viewportWidth", 2560);
  Cypress.config("viewportHeight", 1440);
}
