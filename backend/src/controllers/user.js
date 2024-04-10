const { responseHandler } = require("../utils/apiResponseHandler");
const { User } = require("../models/user");

class UserController {
  async findMany(req, res) {
    try {
    //   const input = req.body;
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

  async findById(req, res) {
    try {
      const user_id = req.params.id;
      
      return responseHandler.successResponseWithData(
        res,
        "User with id: " + user_id,
        {
          name: "John Doe",
        },
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async create(req, res) {
    try {
      const input = req.body;
      const user = new User(
        1,
        input.name,
        input.email,
        input.password
      );
      return responseHandler.successResponseWithData(
        res,
        "User Created",
        user,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async update(req, res) {
    try {
      const user_id = req.params.id;
      
      return responseHandler.successResponseWithData(
        res,
        "Update User with id: " + user_id,
        {
          name: "John Doe",
        },
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async delete(req, res) {
    try {
      const user_id = req.params.id;
      
      return responseHandler.successResponseWithData(
        res,
        "Delete User with id: " + user_id,
        {
          name: "John Doe",
        },
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
