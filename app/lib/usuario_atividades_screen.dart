import 'package:app/data_table_widget.dart';
import 'package:app/user_has_activities_service.dart';
import 'package:flutter/material.dart';

class UsuarioAtividadesScreen extends StatefulWidget {
  @override
  _UsuarioAtividadesScreenState createState() =>
      _UsuarioAtividadesScreenState();
}

class _UsuarioAtividadesScreenState extends State<UsuarioAtividadesScreen> {
  List<List<String>> _usersHasActivitiesTableData = []; // Data for the table

  final TextEditingController _idUsuarioController = TextEditingController();
  final TextEditingController _idAtividadeController = TextEditingController();
  final TextEditingController _notaUsuarioController = TextEditingController();
  final TextEditingController _dataEntregaController = TextEditingController();

  Future<void> _loadUsersHasActivities() async {
    // Fetch atividade data from the backend
    // For demonstration purposes, let's assume AtividadeService.getAtividadeList() returns a list of atividades
    final userHasActivities =
        await UserHasActivitiesService.getAllUserHasActivities();

    setState(() {
      _usersHasActivitiesTableData = userHasActivities;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsersHasActivities(); // Load atividades when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities from Users'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showCreateUserHasActivityModal(context);
                        },
                        child: Text('Associate Activitie with User'),
                      ),
                    ],
                  ),
                ),
                DataTableWidget(
                  // Display the table of atividades
                  fieldNames: ['ID User', 'ID Activitie', 'Grade'],
                  inputData: _usersHasActivitiesTableData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _associateUsuarioAtividade(BuildContext context) async {
    final int idUsuario = int.tryParse(_idUsuarioController.text) ?? 0;
    final int idAtividade = int.tryParse(_idAtividadeController.text) ?? 0;
    final double notaUsuario =
        double.tryParse(_notaUsuarioController.text) ?? 0.0;
    final String dataEntrega = _dataEntregaController.text;

    if (idUsuario <= 0 || idAtividade <= 0 || dataEntrega.isEmpty) {
      _showError('Please fill required fields');
      return;
    }

    try {
      await UserHasActivitiesService.assignActivityToUser(
          idAtividade, idUsuario, notaUsuario);

      await _loadUsersHasActivities();

      _idUsuarioController.clear();
      _idAtividadeController.clear();
      _notaUsuarioController.clear();
      _dataEntregaController.clear();
      Navigator.of(context).pop(); // Close the modal
    } catch (e) {
      // Handle error
      print('Error creating user has activity: $e');
    }
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

  void _showCreateUserHasActivityModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create User Has Activitie'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _idUsuarioController,
                  decoration: InputDecoration(labelText: 'ID User'),
                ),
                TextFormField(
                  controller: _idAtividadeController,
                  decoration: InputDecoration(labelText: 'ID Activity'),
                ),
                TextFormField(
                  controller: _notaUsuarioController,
                  decoration: InputDecoration(labelText: 'Grade'),
                ),
                TextFormField(
                  controller: _dataEntregaController,
                  decoration: InputDecoration(labelText: 'Send date'),
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
                _associateUsuarioAtividade(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
