const express = require("express");
const { Router } = express;
const { userController } = require("../controllers/user");

const userRoutes = Router();

userRoutes.get("/", userController.findMany);

userRoutes.get("/:id", (req, res) => {
    res.send("Get User by id");
});

userRoutes.post("/", (req, res) => {
    res.send("Post Users");
});

userRoutes.patch("/:id", (req, res) => {
    res.send("Patch Users");
});

userRoutes.delete("/:id", (req, res) => {
    res.send("Delete Users");
});

module.exports = {
    userRoutes
}