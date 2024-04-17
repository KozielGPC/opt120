const { db } = require("../providers/database");
const { activityQueries } = require("../queries/activity"); 

class ActivityRepository{
    async findMany() {
        return new Promise((resolve, reject) => {
            db.query(activityQueries.findMany, function (err, result) {
                if (err) {
                    console.error("Error on findMany Activities", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    async findById(id) {
        return new Promise((resolve, reject) => {
            db.query(activityQueries.findById(id), function (err, result) {
                if (err) {
                    console.error("Error on findById Activites", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    async create(activity) {
        return new Promise((resolve, reject) => {
            db.query(activityQueries.create(activity.title, activity.grade, activity.description, activity.deadline), function (err, result) {
                if (err) {
                    console.error("Error on create activity", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    async getLastInsert() {
        return new Promise((resolve, reject) => {
            db.query(activityQueries.getLastInsert, function (err, result) {
                if (err) {
                    console.error("Error on get last activity insert", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    async findByTitle(title) {
        return new Promise((resolve, reject) => {
            db.query(activityQueries.findByTitle(title), function (err, result) {
                if (err) {
                    console.error("Error on findByTitle Activities", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    update(activity) {
        return activity;
    }

    async delete(id) {
        return new Promise((resolve, reject) => {
            db.query(activityQueries.deleteById(id), function (err, result) {
                if (err) {
                    console.error("Error on deleteById Activities", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }
}

const activityRepository = new ActivityRepository();

module.exports = {
    activityRepository
}