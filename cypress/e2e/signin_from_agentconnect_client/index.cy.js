//

describe("sign-in from agentconnect client", () => {
  before(() => {
    cy.seed(__dirname);
  });

  after(() => {
    cy.exec(`docker compose --project-directory ${__dirname} stop`);
  });

  it("should sign-in", function () {
    cy.visit(`http://moncomptepro-agentconnect-client.localhost`);
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
