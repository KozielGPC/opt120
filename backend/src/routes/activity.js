const express = require("express");
const { Router } = express;

const activityRoutes = Router();

activityRoutes.get("/", (req, res) => {
    res.send("Hello World!");
});

module.exports = {
    activityRoutes
}