const { responseHandler } = require("../utils/apiResponseHandler");
const { User } = require("../models/user");
const { userRepository } = require("../repository/user");

class UserController {
  async findMany(req, res) {
    try {
      //   const input = req.body;
      const users = await userRepository.findMany();
      return responseHandler.successResponseWithData(
        res,
        "Many Users",
        users,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async findById(req, res) {
    try {
      const user_id = req.params.id;

      const user = await userRepository.findById(user_id);

      return responseHandler.successResponseWithData(
        res,
        "User with id: " + user_id,
        user,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async create(req, res) {
    try {
      const input = req.body;
      const user = new User(1, input.name, input.email, input.password);

      userRepository.create(user);
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

      const user = userRepository.findById(user_id);

      const updated_user = userRepository.update(user);
      return responseHandler.successResponseWithData(
        res,
        "Update User with id: " + user_id,
        updated_user,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async delete(req, res) {
    try {
      const user_id = req.params.id;

      const user = await userRepository.findById(user_id);

      await userRepository.delete(user);

      return responseHandler.successResponseWithData(
        res,
        "Delete User with id: " + user_id,
        user,
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
