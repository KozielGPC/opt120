const express = require("express");
const cors = require("cors");
const { activityRoutes } = require("./routes/activity");
const { userRoutes } = require("./routes/user");
const { authRoutes } = require("./routes/auth");
const { userHasActivityRoutes } = require("./routes/user-has-activity");
const { db } = require("./providers/database");
const { verifyToken } = require('./middlewares/auth');

const app = express();

app.use(cors());
app.use(express.json());

app.use("/auth", authRoutes);
app.use("/activity", verifyToken, activityRoutes);
app.use("/user", verifyToken, userRoutes);
app.use("/user-has-activity", verifyToken, userHasActivityRoutes);

db.connect(function (err) {
  if (err) {
    console.log("Failed to connect to database!");
    throw err;
  }
  console.log("Connected!");

  db.query("create database if not exists opt120", function (err, result) {
    if (err) throw err;
    console.log("Creating opt120");
  });

  db.query("use opt120", function (err, result) {
    if (err) throw err;
    console.log("Using opt120");
  });
});

module.exports = {
  app,
};
