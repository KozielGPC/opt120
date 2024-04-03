import 'package:app/api_service.dart';

class UserHasActivitiesService {
  static Future<List<List<String>>>  getAllUserHasActivities() async {
    try {
      // final response = await ApiService.get('user_has_activities');
      // return List<Map<String, dynamic>>.from(response['user_has_activities']);
      final List<Map<String, dynamic>> mockedUserHasActivities = [
        {'id_usuario': 1, 'id_atividade': 1, 'nota_usuario': 8.0},
        {'id_usuario': 2, 'id_atividade': 1, 'nota_usuario': 7.5},
      ];

      final List<List<String>> usersHasActivitiesList = mockedUserHasActivities.map((user) {
        return [user['id_usuario'].toString(), user['id_atividade'].toString(), user['nota_usuario'].toString()];
      }).toList();
      return usersHasActivitiesList;
    } catch (e) {
      print('Error fetching user-has-activities list: $e');
      rethrow; 
    }
  }

  static Future<void> assignActivityToUser(int userId, int activityId, double userGrade) async {
    try {
      final payload = {
        'id_usuario': userId,
        'id_atividade': activityId,
        'nota_usuario': userGrade,
      };
      await ApiService.post('user_has_activities', payload);
    } catch (e) {
      print('Error assigning activity to user: $e');
      rethrow; 
    }
  }

  static Future<void> deleteUserActivityRelation(int userId, int activityId) async {
    try {
      await ApiService.delete('user_has_activities/$userId/$activityId');
    } catch (e) {
      print('Error deleting user activity relation: $e');
      rethrow; 
    }
  }

  static Future<void> updateUserActivityGrade(int userId, int activityId, double userGrade) async {
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
