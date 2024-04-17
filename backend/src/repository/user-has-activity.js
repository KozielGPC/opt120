const { db } = require("../providers/database");
const { userHasActivityQueries } = require("../queries/user-has-activity");

class UserHasActivityRepository {
    async findMany() {
        return new Promise((resolve, reject) => {
            db.query(userHasActivityQueries.findMany, function (err, result) {
                if (err) {
                    console.error("Error on findMany Users", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    async findById(id) {
        return new Promise((resolve, reject) => {
            db.query(userQueries.findById(id), function (err, result) {
                if (err) {
                    console.error("Error on findById Users", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
        // return {
        //     id,
        //     name: "John Doe",
        // };
    }

    async create(userHasActivity) {
        return new Promise((resolve, reject) => {
            db.query(userHasActivityQueries.create(userHasActivity.user_id, userHasActivity.activity_id, userHasActivity.user_grade, userHasActivity.delivery_date), function (err, result) {
                if (err) {
                    console.error("Error on create userHasActivity", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }

    async findByEmail(email) {
        return new Promise((resolve, reject) => {
            db.query(userQueries.findByEmail(email), function (err, result) {
                if (err) {
                    console.error("Error on findByEmail Users", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
        // return {
        //     id,
        //     name: "John Doe",
        // };
    }

    update(user) {
        return user;
    }

    async delete(id) {
        return new Promise((resolve, reject) => {
            db.query(userQueries.deleteById(id), function (err, result) {
                if (err) {
                    console.error("Error on deleteById Users", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
    }
}

const userHasActivityRepository = new UserHasActivityRepository();

module.exports = {
    userHasActivityRepository
}