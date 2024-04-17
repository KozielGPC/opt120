const findMany = "SELECT * FROM user_has_activities";

const findByUserIdAndActivityId = (id_user, id_activity) => `SELECT * FROM user_has_activities WHERE id_user = ${id_user} and id_activity = ${id_activity}`;

const findByEmail = (email) => `SELECT * FROM users WHERE email = '${email}'`;

const create = (id_user, id_activity, user_grade, delivery_date) =>
  `INSERT INTO user_has_activities (id_user, id_activity, user_grade, delivery_date) VALUES ('${id_user}', '${id_activity}', '${user_grade}', '${delivery_date}')`;

const update = (id_user, id_activity, user_grade) =>
  `UPDATE user_has_activities SET user_grade = '${user_grade}' WHERE id_user = ${id_user} and id_activity = ${id_activity}`;

const deleteByUserIdAndActivityId = (id_user, id_activity) => `DELETE FROM user_has_activities WHERE id_user = ${id_user} and id_activity = ${id_activity}`;


const userHasActivityQueries = {
  findMany,
  findByUserIdAndActivityId,
  create,
  update,
  deleteByUserIdAndActivityId,
  findByEmail
};

module.exports = {
  userHasActivityQueries,
};
