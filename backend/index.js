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

  con.query("create database if not exists opt120", function (err, result) {
    if (err) throw err;
    console.log("Creating opt120");
  });

  con.query("use opt120", function (err, result) {
    if (err) throw err;
    console.log("Using opt120");
  });

  con.query("SELECT * FROM usuario", function (err, result) {
    if (err) throw err;
    console.log("Result: " + JSON.stringify(result));
  });
});

app.get('/', (req, res) => {
  con.query("use opt120", function (err, result) {
    if (err) throw err;
    console.log("Using opt120");
  });

  con.query("SELECT * FROM usuario", function (err, result) {
    if (err) throw err;
    console.log("Result: " + JSON.stringify(result));
    res.send(JSON.stringify(result))
  });
  
})

app.get('/activities', (req, res) => {
  con.query("use opt120", function (err, result) {
    if (err) throw err;
    console.log("Using opt120");
  });

  con.query("SELECT * FROM atividades", function (err, result) {
    if (err) throw err;
    console.log("Result: " + JSON.stringify(result));
    res.send(JSON.stringify(result))
  });
  
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

