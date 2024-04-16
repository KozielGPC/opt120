import 'package:app/api_service.dart';

class UserService {
  static Future<void> createUser(String nome, String email, String senha) async {
    try {
      final payload = {
        'nome': nome,
        'email': email,
        'senha': senha,
      };
      await ApiService.post('user', payload);
      print('User created successfully');
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  static Future<List<List<String>>> getUserList() async {
    try {
      final response = await ApiService.get('user');
      final users = List<Map<String, dynamic>>.from(response['data']);

      final List<List<String>> usersList = users.map((user) {
        return [user['id'].toString(), user['name'].toString(), user['email'].toString()];
      }).toList();

      return usersList;
    } catch (e) {
      print('Error fetching user list: $e');
      rethrow;
    }
  }

  static Future<void> deleteUser(String id) async {
    try {
      await ApiService.delete('user/$id');
      print('User deleted successfully');
    } catch (e) {
      print('Error fetching user list: $e');
      rethrow;
    }
  }
}
