const { db } = require("../providers/database");
const { userQueries } = require("../queries/user"); 

class UserRepository{
    async findMany() {
        return new Promise((resolve, reject) => {
            db.query(userQueries.findMany, function (err, result) {
                if (err) {
                    console.error("Error on findMany Users", err);
                    reject(err);
                } else {
                    resolve(result);
                }
            });
        });
        // return [
        //     {
        //         id: 1,
        //         name: "John Doe",
        //     },
        //     {
        //         id: 2,
        //         name: "Jane Doe",
        //     },
        // ];
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

    create(user) {
        return user;
    }

    update(user) {
        return user;
    }

    delete(id) {
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

const userRepository = new UserRepository();

module.exports = {
    userRepository
}