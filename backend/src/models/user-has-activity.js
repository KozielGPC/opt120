class UserHasActivity {
  constructor(user_id, activity_id, user_grade, delivery_date) {
    this.user_id = user_id;
    this.activity_id = activity_id;
    this.user_grade = user_grade;
    this.delivery_date = delivery_date;
  }
}

module.exports = { UserHasActivity };
