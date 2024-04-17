const express = require("express");
const { Router } = express;
const { activityController } = require("../controllers/activity");

const activityRoutes = Router();

activityRoutes.get("/", activityController.findMany);

activityRoutes.get("/:id", activityController.findById);

activityRoutes.post("/", activityController.create);

activityRoutes.patch("/:id", activityController.update);

activityRoutes.delete("/:id", activityController.delete);

module.exports = {
    activityRoutes
}