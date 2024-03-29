import 'package:flutter/material.dart';

class AtividadesScreen extends StatefulWidget {
  @override
  _AtividadesScreenState createState() => _AtividadesScreenState();
}

class _AtividadesScreenState extends State<AtividadesScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataLimiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Atividade'),
        ),
        body: Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: Card(
                  margin: EdgeInsets.all(16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _tituloController,
                          decoration: InputDecoration(labelText: 'Titulo'),
                        ),
                        TextFormField(
                          controller: _notaController,
                          decoration: InputDecoration(labelText: 'Nota'),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: _descricaoController,
                          decoration: InputDecoration(labelText: 'Descricao'),
                        ),
                        TextFormField(
                          controller: _dataLimiteController,
                          decoration: InputDecoration(
                              labelText: 'Data Limite (YYYY-MM-DD)'),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _createAtividade();
                          },
                          child: Text('Create'),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  void _createAtividade() {
    final String titulo = _tituloController.text;
    final double nota = double.tryParse(_notaController.text) ?? 0.0;
    final String descricao = _descricaoController.text;
    final String dataLimite = _dataLimiteController.text;

    if (titulo.isEmpty || dataLimite.isEmpty) {
      _showError('Please fill required fields');
      return;
    }

    print('Titulo: $titulo');
    print('Nota: $nota');
    print('Descricao: $descricao');
    print('Data Limite: $dataLimite');

    _tituloController.clear();
    _notaController.clear();
    _descricaoController.clear();
    _dataLimiteController.clear();

    _showSuccess('Atividade created successfully');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
