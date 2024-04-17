const findMany = "SELECT * FROM user_has_activities";

const findById = (user_id) => `SELECT * FROM users WHERE id = ${user_id}`;

const findByEmail = (email) => `SELECT * FROM users WHERE email = '${email}'`;

const create = (id_user, id_activity, user_grade, delivery_date) =>
  `INSERT INTO user_has_activities (id_user, id_activity, user_grade, delivery_date) VALUES ('${id_user}', '${id_activity}', '${user_grade}', '${delivery_date}')`;

const update = (user_id, name, email, password) =>
  `UPDATE users SET name = '${name}', email = '${email}', password = '${password}' WHERE id = ${user_id}`;

const deleteById = (user_id) => `DELETE FROM users WHERE id = ${user_id}`;


const userHasActivityQueries = {
  findMany,
  findById,
  create,
  update,
  deleteById,
  findByEmail
};

module.exports = {
  userHasActivityQueries,
};
