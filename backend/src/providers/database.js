const mysql = require('mysql');
const { config } = require("../config");

const db = mysql.createConnection({
  host: config.DB_HOST,
  port: config.DB_PORT,
  user: config.DB_USER,
  password: config.DB_PASSWORD,
  database: config.DB_NAME
});

module.exports = {
    db
}
