const { responseHandler } = require("../utils/apiResponseHandler");

class UserController {
  async findMany(req, res) {
    try {
      return responseHandler.successResponseWithData(
        res,
        "Many Users",
        [
          {
            name: "John Doe",
          },
          {
            name: "Jane Smith",
          },
        ],
        200
      );
    } catch (error) {
      throw error;
    }
  }
}

const userController = new UserController();

module.exports = {
  userController,
};
