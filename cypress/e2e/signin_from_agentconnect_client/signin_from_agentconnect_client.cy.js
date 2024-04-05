const MONCOMPTEPRO_HOST =
  Cypress.env("MONCOMPTEPRO_HOST") || "http://localhost:3000";

describe("sign-in from agentconnect client", () => {
  it("should sign-in", function () {
    cy.visit(`http://localhost:4001`);
    cy.get("button.moncomptepro-button").click();

    cy.get('[name="password"]').type("password123");
    cy.get('[action="/users/sign-in"]  [type="submit"]')
      .contains("S’identifier")
      .click();

    cy.contains("moncomptepro-agentconnect-client");
    cy.contains("unused1@yopmail.com");
    cy.contains("21340126800130");
  });
});
