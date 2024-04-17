const express = require("express");
const { Router } = express;
const { userHasActivityController } = require("../controllers/user-has-activity");

const userHasActivityRoutes = Router();

userHasActivityRoutes.get("/", userHasActivityController.findMany);

// userHasActivityRoutes.get("/:id", userHasActivityController.findById);

userHasActivityRoutes.post("/", userHasActivityController.create);

userHasActivityRoutes.patch("/user/:id_user/activity/:id_activity", userHasActivityController.update);

userHasActivityRoutes.delete("/user/:id_user/activity/:id_activity", userHasActivityController.delete);

module.exports = {
    userHasActivityRoutes
}