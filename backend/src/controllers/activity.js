const { responseHandler } = require("../utils/apiResponseHandler");
const { Activity } = require("../models/activity");
const { activityRepository } = require("../repository/activity");

class ActivityController {
  async findMany(req, res) {
    try {
      //   const input = req.body;
      const activities = await activityRepository.findMany();
      return responseHandler.successResponseWithData(
        res,
        "Many Activities",
        activities,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async findById(req, res) {
    try {
      const activity_id = req.params.id;

      const activity = await activityRepository.findById(activity_id);

      return responseHandler.successResponseWithData(
        res,
        "Activity with id: " + activity_id,
        activity,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async create(req, res) {
    try {
      const input = req.body;

      const titleExists = await activityRepository.findByTitle(input.title);

      if (titleExists.length > 0) {
        return responseHandler.validationErrorResponse(
          res,
          "Title already exists"
        );
      }

      const activity = new Activity(
        null,
        input.title,
        input.grade,
        input.description,
        input.deadline
      );

      await activityRepository.create(activity);

      const createdActivity = await activityRepository.getLastInsert();

      return responseHandler.successResponseWithData(
        res,
        "Activity Created",
        createdActivity,
        200
      );
    } catch (error) {
      throw error;
    }
  }

  async update(req, res) {
    try {
      const activity_id = req.params.id;

      const activity = await activityRepository.findById(activity_id);

      if (!activity) {
        return responseHandler.notFoundResponse(
          res,
          "Activity with id: " + activity_id + " not found"
        );
      }

      const input = req.body;

      const activity_input = new Activity(
        activity_id,
        input.title ?? activity.title,
        input.grade ?? activity.grade,
        input.description ?? activity.description,
        input.deadline ?? activity.deadline
      );

      await activityRepository.update(activity_input);

      return responseHandler.successResponseWithData(
        res,
        "Update Activity with id: " + user_id,
        updated_activity,
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

      const user_input = new User(
        user_id,
        input.name ?? user.name,
        input.email ?? user.email,
        input.password ?? user.password
      );

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
      const activity_id = req.params.id;

      const activity = await activityRepository.findById(activity_id);

      await activityRepository.delete(activity_id);

      return responseHandler.successResponseWithData(
        res,
        "Delete activity with id: " + activity_id,
        activity,
        200
      );
    } catch (error) {
      throw error;
    }
  }
}

const activityController = new ActivityController();

module.exports = {
  activityController,
};
