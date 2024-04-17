const findMany = "SELECT * FROM user_has_activities";

const findById = (user_id) => `SELECT * FROM users WHERE id = ${user_id}`;

const findByEmail = (email) => `SELECT * FROM users WHERE email = '${email}'`;

const create = (name, email, password) =>
  `INSERT INTO users (name, email, password) VALUES ('${name}', '${email}', '${password}')`;

const update = (user_id, name, email, password) =>
  `UPDATE users SET name = '${name}', email = '${email}', password = '${password}' WHERE id = ${user_id}`;

const deleteById = (user_id) => `DELETE FROM users WHERE id = ${user_id}`;

const getLastInsert = `SELECT * FROM users WHERE id = LAST_INSERT_ID();`;

const userHasActivityQueries = {
  findMany,
  findById,
  create,
  update,
  deleteById,
  getLastInsert,
  findByEmail
};

module.exports = {
  userHasActivityQueries,
};
