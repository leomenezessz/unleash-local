const unleash = require('unleash-server');

const {
  UNLEASH_AUTH_TYPE,
} = process.env;

let unleashOptions = {
  adminAuthentication: UNLEASH_AUTH_TYPE
};

unleash.start(unleashOptions).then((unleash) => {
  console.log(`Unleash started on http://localhost:${unleash.app.get("port")}`);
});
