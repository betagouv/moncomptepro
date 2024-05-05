//

describe(
  "join organizations",
  { baseUrl: "http://app.moncomptepro.localhost" },
  () => {
    before(() => {
      cy.seed(__dirname);
      cy.mailslurp().then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "233fd508-224d-4fe7-88ed-0a0d1df10e07",
        }),
      );
      cy.mailslurp().then((mailslurp) =>
        mailslurp.inboxController.deleteAllInboxEmails({
          inboxId: "ba97e7a6-e603-465e-b2a5-236489ee0bb2",
        }),
      );
    });

    after(() => {
      cy.exec(`docker compose --project-directory ${__dirname} stop`);
    });

    it("join organisation via sponsorship", function () {
      cy.login(
        "233fd508-224d-4fe7-88ed-0a0d1df10e07@mailslurp.com",
        "password123",
      );

      cy.visit(`/users/join-organization`);

      // Click on the suggested organization
      cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();

      // Open member selection
      cy.get(".choices").click();

      // Internal active members should be available for selection
      cy.get(".choices__list").contains("Jean SponsorActive - Sbire");
      cy.get(".choices__list").contains("Jean SponsorChosen - Sbire");

      // Current user should not be available for selection
      cy.get(".choices__list")
        .contains("Jean Nouveau - Sbire")
        .should("not.exist");

      // External member should not be available for selection
      cy.get(".choices__list")
        .contains("Jean External1 - Sbire")
        .should("not.exist");

      // Member that has not been authenticated yet should not be seen
      cy.get(".choices__list")
        .contains("Jean NotAuthenticated1 - Sbire")
        .should("not.exist");

      // Member that has not been authenticated yet should not be seen
      cy.get(".choices__list")
        .contains("Jean NeedsOfficialContactEmailVerification1 - Sbire")
        .should("not.exist");

      // Member that has not been authenticated yet should not be seen
      cy.get(".choices__list")
        .contains("Jean NotActive1 - Sbire")
        .should("not.exist");

      // Select second member
      cy.get('[name="search_terms"]').type("SponsorChosen{enter}");

      cy.get('[type="submit"]').click();

      cy.contains("Votre compte est créé");
      cy.contains("Jean SponsorChosen a été informé");
    });

    it("should send mail to sponsor", function () {
      cy.mailslurp()
        // use inbox id and a timeout of 30 seconds
        .then((mailslurp) =>
          mailslurp.waitForLatestEmail(
            "ba97e7a6-e603-465e-b2a5-236489ee0bb2",
            60000,
            true,
          ),
        )
        // assert reception of notification email
        .then((email) => {
          expect(email.body).to.match(
            /.*Jean.Nouveau.*\(233fd508-224d-4fe7-88ed-0a0d1df10e07@mailslurp.com\).*a rejoint l’organisation.*Direction interministerielle du numerique \(DINUM\).*sur .*MonComptePro/,
          );
        });
    });

    it("should not be able to select another sponsor", () => {
      cy.login(
        "233fd508-224d-4fe7-88ed-0a0d1df10e07@mailslurp.com",
        "password123",
      );

      cy.visit(`/users/choose-sponsor/1`);

      // Open member selection
      cy.get(".choices").click();

      // Select second member
      cy.get('[name="search_terms"]').type("Nouveau{enter}");

      cy.get('[type="submit"]').click();

      cy.contains("Une erreur est survenue.");
    });

    it("should not see sponsorship screen when whitelisted", () => {
      cy.login("unused@fakedomain.com", "password123");

      cy.visit(`/users/join-organization`);

      // Click on the suggested organization
      cy.get(".fr-grid-row .fr-col-12:first-child .fr-tile__link").click();

      // should not see sponsorship screen
      cy.contains("Votre compte est créé");
    });
  },
);
