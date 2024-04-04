import 'package:app/api_service.dart';

class UserService {
  static Future<void> createUser(String nome, String email, String senha) async {
    try {
      final payload = {
        'nome': nome,
        'email': email,
        'senha': senha,
      };
      await ApiService.post('users', payload);
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  static Future<List<List<String>>> getUserList() async {
    try {
      // final response = await ApiService.get('users');
      // return List<Map<String, dynamic>>.from(response['users']);
      final List<Map<String, dynamic>> mockedUsers = [
        {'name': 'John Doe', 'email': 'john@example.com'},
        {'name': 'Jane Smith', 'email': 'jane@example.com'},
      ];

      final List<List<String>> usersList = mockedUsers.map((user) {
        return [user['name'].toString(), user['email'].toString()];
      }).toList();

      return usersList;
    } catch (e) {
      print('Error fetching user list: $e');
      rethrow;
    }
  }
}
