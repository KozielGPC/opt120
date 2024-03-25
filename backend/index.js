const express = require('express')
const app = express()
const port = 3000



var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  port: 3306,
  user: "root",
  password: "root"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");

  con.query("use progapp", function (err, result) {
    if (err) throw err;
    console.log("Using progapp");
  });

  con.query("SELECT * FROM usuario", function (err, result) {
    if (err) throw err;
    console.log("Result: " + JSON.stringify(result));
  });
});

app.get('/', (req, res) => {
  con.query("use progapp", function (err, result) {
    if (err) throw err;
    console.log("Using progapp");
  });

  con.query("SELECT * FROM usuario", function (err, result) {
    if (err) throw err;
    console.log("Result: " + JSON.stringify(result));
    res.send(JSON.stringify(result))
  });
  
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

