const { app } = require("./app");
const { config } = require("./config");

const port = config.PORT ?? 3001;

app.listen(port, () => {
	console.log(`Server is running at http://localhost:${+port}`);
});