const express = require("express");
const { Router } = express;
const { authController } = require("../controllers/auth");

const authRoutes = Router();

authRoutes.post("/login", authController.login);


module.exports = {
    authRoutes
}