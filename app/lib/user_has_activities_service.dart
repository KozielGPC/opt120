import 'package:app/api_service.dart';

class UserHasActivitiesService {
  static Future<List<List<String>>> getAllUserHasActivities() async {
    try {
      final response = await ApiService.get('user-has-activity');
      final userHasActivities =
          List<Map<String, dynamic>>.from(response['data']);

      final List<List<String>> usersHasActivitiesList =
          userHasActivities.map((userHasActivity) {
        return [
          userHasActivity['id_user'].toString(),
          userHasActivity['id_activity'].toString(),
          userHasActivity['user_grade'].toString(),
          userHasActivity['delivery_date'].toString()
        ];
      }).toList();
      return usersHasActivitiesList;
    } catch (e) {
      print('Error fetching user-has-activities list: $e');
      rethrow;
    }
  }

  static Future<void> assignActivityToUser(
      int userId, int activityId, double userGrade, String sendDate) async {
    try {
      final payload = {
        'user_id': userId,
        'activity_id': activityId,
        'user_grade': userGrade,
        'delivery_date': sendDate
      };

      final response = await ApiService.post('user-has-activity', payload);
      return response['data'][0];
    } catch (e) {
      print('Error assigning activity to user: $e');
      rethrow;
    }
  }

  static Future<void> deleteUserHasActivity(
      int userId, int activityId) async {
    try {
      await ApiService.delete('user-has-activity/user/$userId/activity/$activityId');

      print('User Activity deleted successfully');
    } catch (e) {
      print('Error deleting user activity relation: $e');
      rethrow;
    }
  }

  static Future<void> updateUserActivityGrade(
      int userId, int activityId, double userGrade) async {
    try {
      final payload = {
        'nota_usuario': userGrade,
      };
      await ApiService.put('user_has_activities/$userId/$activityId', payload);
    } catch (e) {
      print('Error updating user activity grade: $e');
      rethrow;
    }
  }
}
