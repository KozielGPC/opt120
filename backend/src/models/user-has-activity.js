class UserHasActivity {
  constructor(user_id, activity_id, user_grade, send_date) {
    this.user_id = user_id;
    this.activity_id = activity_id;
    this.user_grade = user_grade;
    this.send_date = send_date;
  }
}

module.exports = { UserHasActivity };
