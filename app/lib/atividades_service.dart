import 'package:app/api_service.dart';

class AtividadeService {
  // Mocked atividade list for demonstration
  static Future<List<List<String>>> getAtividadeList() async {
    try {
      // final response = await ApiService.get('activites');
      // return List<Map<String, dynamic>>.from(response['activites']);
      final List<Map<String, dynamic>> mockedAtividades = [
        {'titulo': 'Atividade 1', 'nota': 8.5, 'descricao': 'Descrição da atividade 1'},
        {'titulo': 'Atividade 2', 'nota': 7.0, 'descricao': 'Descrição da atividade 2'},
        // Add more mocked atividades as needed
      ];

      // Convert each map to a list of strings
      final List<List<String>> atividadesList = mockedAtividades.map((user) {
        return [user['titulo'].toString(), user['nota'].toString(), user['descricao'].toString()];
      }).toList();

      return atividadesList;
    } catch (e) {
      print('Error fetching activites list: $e');
      rethrow; // Re-throw the error to propagate it to the caller
    }
  }
}
