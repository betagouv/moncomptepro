module.exports = {
  chromeWebSecurity: false,
  defaultCommandTimeout: 60000,
  pageLoadTimeout: 60000,
  e2e: {
    // baseUrl: "http://app.moncomptepro.localhost",
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      on("task", {
        log(message) {
          console.log(message);

          return null;
        },
      });
      return require("./cypress/plugins/index.js")(on, config);
    },
  },
  video: true,
};
