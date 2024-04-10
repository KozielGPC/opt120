const express = require("express");
const { Router } = express;

const userRoutes = Router();

userRoutes.get("/", (req, res) => {
    res.send("Hello World!");
});

module.exports = {
    userRoutes
}