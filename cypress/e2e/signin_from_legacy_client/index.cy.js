//

describe("sign-in from legacy client", () => {
  before(() => {
    cy.seed(__dirname);
  });

  after(() => {
    cy.exec(`docker compose --project-directory ${__dirname} stop`);
  });

  it("should sign-in", function () {
    cy.visit(`http://moncomptepro-legacy-client.localhost/`);
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
    cy.visit(`http://moncomptepro-standard-client.localhost/`);
    cy.get("button.moncomptepro-button").click();
    cy.contains("Votre organisation de rattachement");
    cy.contains("Commune de lamalou-les-bains - Mairie").click();
    cy.contains("moncomptepro-standard-client");
    cy.contains("Commune de lamalou-les-bains - Mairie");
  });
});
