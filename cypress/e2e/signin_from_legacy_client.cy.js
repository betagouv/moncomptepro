//

before(() => {
  cy.seed();
});

describe("sign-in from legacy client", () => {
  it("should sign-in", function () {
    cy.visit(`http://localhost:4002`);
    cy.get("button.moncomptepro-button").click();

    cy.get('[name="login"]').type("unused1@yopmail.com");
    cy.get('[type="submit"]').click();

    cy.get('[name="password"]').type("password123");
    cy.get('[action="/users/sign-in"]  [type="submit"]')
      .contains("S’identifier")
      .click();

    cy.contains("moncomptepro-legacy-client");
    cy.contains("unused1@yopmail.com");
    cy.contains("Commune de lamalou-les-bains");

    // then it should prompt for organization
    cy.visit(`http://localhost:4000`);
    cy.get("button.moncomptepro-button").click();
    cy.contains("Votre organisation de rattachement");
    cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();
    cy.contains("moncomptepro-standard-client");
    cy.contains("Commune de lamalou-les-bains - Mairie");
  });
});
