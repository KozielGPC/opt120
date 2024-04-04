import 'package:app/api_service.dart';

class AtividadeService {
  static Future<List<List<String>>> getAtividadeList() async {
    try {
      // final response = await ApiService.get('activites');
      // return List<Map<String, dynamic>>.from(response['activites']);
      final List<Map<String, dynamic>> mockedAtividades = [
        {'titulo': 'Atividade 1', 'nota': 8.5, 'descricao': 'Descrição da atividade 1'},
        {'titulo': 'Atividade 2', 'nota': 7.0, 'descricao': 'Descrição da atividade 2'},
      ];

      final List<List<String>> atividadesList = mockedAtividades.map((user) {
        return [user['titulo'].toString(), user['nota'].toString(), user['descricao'].toString()];
      }).toList();

      return atividadesList;
    } catch (e) {
      print('Error fetching activites list: $e');
      rethrow; 
    }
  }

  static Future<void> createAtividade(String titulo, String nota, String descricao) async {
    try {
      final payload = {
        'titulo': titulo,
        'nota': nota,
        'descricao': descricao,
      };
      await ApiService.post('activites', payload);
    } catch (e) {
      print('Error creating activity: $e');
      rethrow; 
    }
  }
}
