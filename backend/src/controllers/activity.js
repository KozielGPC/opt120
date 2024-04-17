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

      const activity = new Activity(null, input.title, input.grade, input.description, input.deadline);

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

      const activity = activityRepository.findById(activity_id);

      const updated_activity = activityRepository.update(activity);
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
