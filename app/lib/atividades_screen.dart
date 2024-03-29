import 'package:flutter/material.dart';
import 'package:app/data_table_widget.dart'; // Import the DataTableWidget
import 'package:app/atividades_service.dart'; // Import the AtividadeService or wherever you fetch atividade data from

class AtividadesScreen extends StatefulWidget {
  @override
  _AtividadeScreenState createState() => _AtividadeScreenState();
}

class _AtividadeScreenState extends State<AtividadesScreen> {
  List<List<String>> _atividadeTableData = []; // Data for the table

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
                          // Handle button press to create new atividade
                        },
                        child: Text('Create Atividade'),
                      ),
                    ],
                  ),
                ),
                DataTableWidget( // Display the table of atividades
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
}
