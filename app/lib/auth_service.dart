import 'package:app/api_service.dart';

class AuthService {
  static Future login(String email, String password) async {
    try {
      final payload = {
        'email': email,
        'password': password,
      };
      final response = await ApiService.post('auth/login', payload);
      return response['data'];
    } catch (e) {
      print('Error during login: $e');
      rethrow; 
    }
  }
}
