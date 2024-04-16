const findMany = "SELECT * FROM users";

const findById = (user_id) => `SELECT * FROM users WHERE id = ${user_id}`;

const create = (name, email, password) =>
  `INSERT INTO users (name, email, password) VALUES ('${name}', '${email}', '${password}')`;

const update = (user_id, name, email, password) =>
  `UPDATE users SET name = '${name}', email = '${email}', password = '${password}' WHERE id = ${user_id}`;

const deleteById = (user_id) => `DELETE FROM users WHERE id = ${user_id}`;

const userQueries = {
  findMany,
  findById,
  create,
  update,
  deleteById,
};

module.exports = {
  userQueries,
};
