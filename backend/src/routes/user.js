const express = require("express");
const { Router } = express;
const { userController } = require("../controllers/user");

const userRoutes = Router();

userRoutes.get("/", userController.findMany);

userRoutes.get("/:id", userController.findById);

userRoutes.post("/", userController.create);

userRoutes.patch("/:id", userController.update);

userRoutes.delete("/:id", userController.delete);

module.exports = {
    userRoutes
}