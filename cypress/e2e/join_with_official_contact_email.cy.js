//

describe("join organizations", () => {
  before(() => {
    cy.seed(__filename.split("/").at(-1).replace(".cy.js", ""));
  });

  beforeEach(() => {
    cy.mailslurp().then((mailslurp) =>
      mailslurp.inboxController.deleteAllInboxEmails({
        inboxId: "435f6a4d-df7d-4840-be7b-bc4851b64e91",
      }),
    );
  });

  it("join collectivité territoriale with official contact email", function () {
    cy.login(
      "435f6a4d-df7d-4840-be7b-bc4851b64e91@mailslurp.com",
      "password123",
    );

    cy.visit(`/users/join-organization`);
    cy.get('[name="siret"]').type("21340126800130");
    cy.get('[type="submit"]').click();

    cy.contains("Votre compte est créé");
  });

  it("join primary school with official contact email", function () {
    cy.login(
      "435f6a4d-df7d-4840-be7b-bc4851b64e91@mailslurp.com",
      "password123",
    );

    cy.visit(`/users/join-organization`);
    cy.get('[name="siret"]').type("21340126800049");
    cy.get('[type="submit"]').click();

    cy.contains("Votre compte est créé");
  });
});
