import 'package:flutter/material.dart';
import 'package:app/data_table_widget.dart'; // Import the DataTableWidget
import 'package:app/atividades_service.dart'; // Import the AtividadeService or wherever you fetch atividade data from

class AtividadesScreen extends StatefulWidget {
  @override
  _AtividadesScreenState createState() => _AtividadesScreenState();
}

class _AtividadesScreenState extends State<AtividadesScreen> {
  List<List<String>> _atividadeTableData = []; // Data for the table

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAtividades(); // Load atividades when the screen initializes
  }

  Future<void> _loadAtividades() async {
    // Fetch atividade data from the backend
    // For demonstration purposes, let's assume AtividadeService.getAtividadeList() returns a list of atividades
    final atividadeList = await AtividadeService.getAtividadeList();

    setState(() {
      _atividadeTableData = atividadeList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Atividade List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showCreateAtividadeModal(
                              context); // Show modal to create new atividade
                        },
                        child: Text('Create Atividade'),
                      ),
                    ],
                  ),
                ),
                DataTableWidget(
                  // Display the table of atividades
                  fieldNames: ['Titulo', 'Nota', 'Descrição'],
                  inputData: _atividadeTableData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreateAtividadeModal(BuildContext context) {
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController notaController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Atividade'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: InputDecoration(labelText: 'Titulo'),
                ),
                TextFormField(
                  controller: notaController,
                  decoration: InputDecoration(labelText: 'Nota'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: descricaoController,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _createAtividade(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _createAtividade(BuildContext context) async {
    final String titulo = _tituloController.text;
    final String nota = _notaController.text;
    final String descricao = _descricaoController.text;

    try {
      await AtividadeService.createAtividade(titulo, nota, descricao);
      await _loadAtividades();
      _tituloController.clear();
      _notaController.clear();
      _descricaoController.clear();
      Navigator.of(context).pop(); // Close the modal
    } catch (e) {
      // Handle error
      print('Error creating atividade: $e');
    }
  }
}
