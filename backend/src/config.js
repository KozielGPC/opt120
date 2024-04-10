const dotenvConfig = require("dotenv/config");

const config = {
  PORT: process.env.PORT,
  DATABASE_URL: process.env.DATABASE_URL,
};

Object.entries(config).forEach(([key, value]) => {
  if (!value) {
    throw new Error(`Missing environment variable: ${key}`);
  }
});

module.exports = { config };
