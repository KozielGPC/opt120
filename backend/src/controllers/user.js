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

      const emailExists = await userRepository.findByEmail(input.email);

      if (emailExists.length > 0) {
        return responseHandler.validationErrorResponse(
          res,
          "Email already exists"
        );
      }

      const user = new User(null, input.name, input.email, input.password);

      await userRepository.create(user);

      const createdUser = await userRepository.getLastInsert();

      return responseHandler.successResponseWithData(
        res,
        "User Created",
        createdUser,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async update(req, res) {
    try {
      const user_id = req.params.id;

      const user = await userRepository.findById(user_id);

      if (!user) {
        return responseHandler.notFoundResponse(
          res,
          "User with id: " + user_id + " not found"
        );
      }

      const input = req.body;

      const user_input = new User(user_id, input.name ?? user.name, input.email ?? user.email, input.password ?? user.password);

      await userRepository.update(user_input);

      return responseHandler.successResponseWithData(
        res,
        "Update User with id: " + user_id,
        user_input,
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

      if (!user) {
        return responseHandler.notFoundResponse(
          res,
          "User with id: " + user_id + " not found"
        );
      }

      await userRepository.delete(user_id);

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
