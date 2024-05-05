//

describe(
  "sign-in from standard client",
  { baseUrl: "http://moncomptepro-standard-client.localhost" },
  () => {
    before(() => {
      cy.seed(__dirname);
    });

    after(() => {
      cy.exec(`docker compose --project-directory ${__dirname} stop`);
    });

    it("should sign-in without org selection when having only one organization", function () {
      cy.visit(`/`);
      cy.get("button.moncomptepro-button").click();

      cy.get('[name="login"]').type("unused1@yopmail.com");
      cy.get('[type="submit"]').click();

      cy.get('[name="password"]').type("password123");
      cy.get('[action="/users/sign-in"]  [type="submit"]')
        .contains("S’identifier")
        .click();

      cy.contains("moncomptepro-standard-client");
      cy.contains("unused1@yopmail.com");
      cy.contains("Commune de lamalou-les-bains - Mairie");

      // then it should prompt for organization
      cy.get("button#select-organization").click();
      cy.contains("Votre organisation de rattachement");
      cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();
      cy.contains("moncomptepro-standard-client");
      cy.contains("Commune de lamalou-les-bains - Mairie");

      // then it should update userinfo
      cy.contains("Jean Un");
      cy.get("button#update-userinfo").click();
      cy.contains("Renseigner son identité");
      cy.get('[name="family_name"]').type("Moustaki");
      cy.get('[type="submit"]').click();
      cy.contains("moncomptepro-standard-client");
      cy.contains("Moustaki");
    });

    it("should sign-in with org selection when having two organization", function () {
      cy.visit(`/`);
      cy.get("button.moncomptepro-button").click();

      cy.get('[name="login"]').type("unused2@yopmail.com");
      cy.get('[type="submit"]').click();

      cy.get('[name="password"]').type("password123");
      cy.get('[action="/users/sign-in"]  [type="submit"]')
        .contains("S’identifier")
        .click();

      cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").contains(
        "Commune de lamalou-les-bains - Mairie",
      );
      cy.get(".fr-grid-row .fr-col-12:last-child .fr-tile__link").contains(
        "Commune de clamart - Mairie",
      );

      cy.get(".fr-grid-row .fr-col-12:last-child .fr-tile__link").click();

      cy.contains("moncomptepro-standard-client");
      cy.contains("unused2@yopmail.com");
      cy.contains("Commune de clamart - Mairie");

      // then it should prompt for organization
      cy.get("button#select-organization").click();
      cy.contains("Votre organisation de rattachement");
      cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();

      cy.contains("moncomptepro-standard-client");
      cy.contains("Commune de lamalou-les-bains - Mairie");
    });

    it("should prompt for organization selection", function () {});
  },
);
