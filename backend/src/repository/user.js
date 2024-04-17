const { db } = require("../providers/database");
const { userQueries } = require("../queries/user");

class UserRepository {
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
  }

  async findById(id) {
    return new Promise((resolve, reject) => {
      db.query(userQueries.findById(id), function (err, result) {
        if (err) {
          console.error("Error on findById Users", err);
          reject(err);
        } else {
          resolve(result.length > 0 ? result[0] : null);
        }
      });
    });
  }

  async create(user) {
    return new Promise((resolve, reject) => {
      db.query(
        userQueries.create(user.name, user.email, user.password),
        function (err, result) {
          if (err) {
            console.error("Error on create user", err);
            reject(err);
          } else {
            resolve(result);
          }
        }
      );
    });
  }

  async getLastInsert() {
    return new Promise((resolve, reject) => {
      db.query(userQueries.getLastInsert, function (err, result) {
        if (err) {
          console.error("Error on get last user insert", err);
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
  }

  async update(user) {
    return new Promise((resolve, reject) => {
      db.query(
        userQueries.update(user.id, user.name, user.email, user.password),
        function (err, result) {
          if (err) {
            console.error("Error on update User", err);
            reject(err);
          } else {
            resolve(result);
          }
        }
      );
    });
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

const userRepository = new UserRepository();

module.exports = {
  userRepository,
};
