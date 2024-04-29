import 'package:flutter/material.dart';
import 'package:app/data_table_widget.dart';
import 'package:app/atividades_service.dart';

class AtividadesScreen extends StatefulWidget {
  @override
  _AtividadesScreenState createState() => _AtividadesScreenState();
}

class _AtividadesScreenState extends State<AtividadesScreen> {
  List<List<String>> _activityTableData = [];

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    _loadAtividades();
  }

  Future<void> _loadAtividades() async {
    final atividadeList = await AtividadeService.getAtividadeList();

    setState(() {
      _activityTableData = atividadeList;
    });
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

  void _updateActivity(BuildContext context, int index) async {
    final String title = _tituloController.text;
    final String grade = _notaController.text;
    final String description = _descricaoController.text;
    final String deadline = _deadlineController.text;

    final activity = _activityTableData[index];

    try {
      await AtividadeService.updateActivity(activity[0], title, grade, description, deadline);
      _activityTableData[index] = [activity[0], title, grade, description, deadline];

      _showSuccess('Activity updated successfully');

      setState(() {
        _activityTableData = _activityTableData;
      });

      _tituloController.clear();
      _notaController.clear();
      _descricaoController.clear();
      _deadlineController.clear();
      Navigator.of(context).pop();
    } catch (e) {
      _showError('Error updating activity');
    }
  }

  void _showUpdateUserModal(BuildContext context, int index) {
    final activity = _activityTableData[index];
    _tituloController.text = activity[1];
    _notaController.text = activity[2];
    _descricaoController.text = activity[3];
    _deadlineController.text = activity[4];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Activity'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: _notaController,
                  decoration: InputDecoration(labelText: 'Grade'),
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: _deadlineController,
                  decoration: InputDecoration(labelText: 'Deadline'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateActivity(context, index);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
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
                        'Activities List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showCreateAtividadeModal(context);
                        },
                        child: Text('Create Activity'),
                      ),
                    ],
                  ),
                ),
                DataTableWidget(
                  fieldNames: ['ID', 'Title', 'Grade', 'Description', 'Deadline'], 
                  inputData: _activityTableData,
                  deleteRow: (index) {
                    _deleteActivity(context, index);
                  },
                  updateRow: (index) {
                    _showUpdateUserModal(context, index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreateAtividadeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Activity'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: _notaController,
                  decoration: InputDecoration(labelText: 'Grade'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                TextFormField( // Added
                  controller: _deadlineController,
                  decoration: InputDecoration(labelText: 'Deadline (YYYY-MM-DD)'),
                  keyboardType: TextInputType.datetime,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _createActivity(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _createActivity(BuildContext context) async {
    final String titulo = _tituloController.text;
    final String nota = _notaController.text;
    final String descricao = _descricaoController.text;
    final String deadline = _deadlineController.text; 

    try {
      await AtividadeService.createActivity(titulo, nota, descricao, deadline);

      _showSuccess('Activity created successfully');

      await _loadAtividades();
      _tituloController.clear();
      _notaController.clear();
      _descricaoController.clear();
      _deadlineController.clear();
      Navigator.of(context).pop();
    } catch (e) {
      _showError('Error creating activity');
    }
  }

  void _deleteActivity(BuildContext context, int index) async {
    try {
      final activity = _activityTableData[index];
      await AtividadeService.deleteActivity(activity[0]);
      _activityTableData.removeAt(index);
      
      _showSuccess('Activity deleted successfully');

      setState(() {
        _activityTableData = _activityTableData;
      });
    } catch (e) {
      _showError('Error deleting activity');
    }
  }
}
