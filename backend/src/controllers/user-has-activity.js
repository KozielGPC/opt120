const { responseHandler } = require("../utils/apiResponseHandler");
const { UserHasActivity } = require("../models/user-has-activity");
const { userHasActivityRepository } = require("../repository/user-has-activity");

class UserHasActivityController {
  async findMany(req, res) {
    try {
      //   const input = req.body;
      const userHasActivities = await userHasActivityRepository.findMany();
      return responseHandler.successResponseWithData(
        res,
        "Many User Has Activities",
        userHasActivities,
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

      // const emailExists = await userHasActivityRepository.findByEmail(input.email);

      // if (emailExists.length > 0) {
      //   return responseHandler.validationErrorResponse(
      //     res,
      //     "Email already exists"
      //   );
      // }

      const userHasActivity = new UserHasActivity(input.user_id, input.activity_id, input.user_grade, input.delivery_date);

      await userHasActivityRepository.create(userHasActivity);

      return responseHandler.successResponseWithData(
        res,
        "UserHasActivity Created",
        userHasActivity,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async update(req, res) {
    try {
      const id_user = req.params.id_user;
      const id_activity = req.params.id_activity;

      const input = req.body

      const userHasActivity = await userHasActivityRepository.findByUserIdAndActivityId(id_user, id_activity);

      await userHasActivityRepository.update(id_user, id_activity, input.user_grade);

      return responseHandler.successResponseWithData(
        res,
        "Updated userHasActivity with user id: " + id_user + " activity id: " + id_activity,
        userHasActivity,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async delete(req, res) {
    try {
      const id_user = req.params.id_user;
      const id_activity = req.params.id_activity;

      const userHasActivity = await userHasActivityRepository.findByUserIdAndActivityId(id_user, id_activity);

      await userHasActivityRepository.delete(id_user, id_activity);

      return responseHandler.successResponseWithData(
        res,
        "Delete userHasActivity with user id: " + id_user + " activity id: " + id_activity,
        userHasActivity,
        200
      );
    } catch (error) {
      throw error;
    }
  }
}

const userHasActivityController = new UserHasActivityController();

module.exports = {
  userHasActivityController,
};
