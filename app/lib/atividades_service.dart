import 'package:app/api_service.dart';

class AtividadeService {
  static Future<List<List<String>>> getAtividadeList() async {
    try {
      final response = await ApiService.get('activity');
      final activities = List<Map<String, dynamic>>.from(response['data']);

      final List<List<String>> activitiesList = activities.map((activity) {
        return [activity['id'].toString(), activity['title'].toString(), activity['grade'].toString(), activity['description'].toString(), activity['deadline'].toString()];
      }).toList();

      return activitiesList;
    } catch (e) {
      print('Error fetching activites list: $e');
      rethrow; 
    }
  }

  static Future createActivity(String title, String grade, String description, String deadline) async {
    try {
      final payload = {
        'title': title,
        'grade': grade,
        'description': description,
        'deadline': deadline
      };
      final response = await ApiService.post('activity', payload);
      return response['data'][0];
    } catch (e) {
      print('Error creating activity: $e');
      rethrow; 
    }
  }

  static Future<void> deleteActivity(String id) async {
    try {
      await ApiService.delete('activity/$id');
      print('Activity deleted successfully');
    } catch (e) {
      print('Error deleting activity: $e');
      rethrow;
    }
  }
}
