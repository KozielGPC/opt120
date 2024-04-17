const express = require("express");
const { Router } = express;
const { userHasActivityController } = require("../controllers/user-has-activity");

const userHasActivityRoutes = Router();

userHasActivityRoutes.get("/", userHasActivityController.findMany);

// userHasActivityRoutes.get("/:id", userHasActivityController.findById);

// userHasActivityRoutes.post("/", userHasActivityController.create);

// userHasActivityRoutes.patch("/:id", userHasActivityController.update);

// userHasActivityRoutes.delete("/:id", userHasActivityController.delete);

module.exports = {
    userHasActivityRoutes
}