const findMany = "SELECT * FROM activities";

const findById = (user_id) => `SELECT * FROM activities WHERE id = ${user_id}`;

const findByTitle = (title) => `SELECT * FROM activities WHERE title = '${title}'`;

const create = (title, grade, description, deadline) =>
  `INSERT INTO activities (title, grade, description, deadline) VALUES ('${title}', '${grade}', '${description}', '${deadline}')`;

const update = (activity_id, title, grade, description, deadline) =>
  `UPDATE activities SET title = '${title}', grade = '${grade}', description = '${description}', deadline = '${deadline}' WHERE id = ${activity_id}`;

const deleteById = (user_id) => `DELETE FROM activities WHERE id = ${user_id}`;

const getLastInsert = `SELECT * FROM activities WHERE id = LAST_INSERT_ID();`;

const activityQueries = {
  findMany,
  findById,
  create,
  update,
  deleteById,
  getLastInsert,
  findByTitle
};

module.exports = {
  activityQueries,
};
