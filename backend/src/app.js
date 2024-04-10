const express = require("express");
const cors = require("cors");
const { activityRoutes } = require("./routes/activity");
const { userRoutes } = require("./routes/user");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/activity", activityRoutes);
app.use("/user", userRoutes);

module.exports = {
    app
};
