import 'package:flutter/material.dart';
import 'package:app/data_table_widget.dart';
import 'package:app/user_has_activities_service.dart';

class UsuarioAtividadesScreen extends StatefulWidget {
  @override
  _UsuarioAtividadesScreenState createState() =>
      _UsuarioAtividadesScreenState();
}

class _UsuarioAtividadesScreenState extends State<UsuarioAtividadesScreen> {
  List<List<String>> _usersHasActivitiesTableData = [];

  final TextEditingController _idUsuarioController = TextEditingController();
  final TextEditingController _idAtividadeController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _sendDateController = TextEditingController();

  Future<void> _loadUsersHasActivities() async {
    final userHasActivities =
        await UserHasActivitiesService.getAllUserHasActivities();

    setState(() {
      _usersHasActivitiesTableData = userHasActivities;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsersHasActivities();
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
                        child: Text('Associate Activity with User'),
                      ),
                    ],
                  ),
                ),
                DataTableWidget(
                  fieldNames: ['ID User', 'ID Activity', 'Grade', 'Send Date'],
                  inputData: _usersHasActivitiesTableData,
                  deleteRow: (index) {
                    _deleteUserHasActivity(index);
                  },
                  updateRow: (index) {
                    print('Updating row at index $index');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteUserHasActivity(int index) async {
    final int userId = int.tryParse(_usersHasActivitiesTableData[index][0]) ?? 0;
    final int activityId = int.tryParse(_usersHasActivitiesTableData[index][1]) ?? 0;

    if (userId <= 0 || activityId <= 0) {
      _showError('Invalid user or activity ID');
      return;
    }

    try {
      await UserHasActivitiesService.deleteUserHasActivity(userId, activityId);
      _loadUsersHasActivities();
      _showSuccess('User has activity deleted successfully');
    } catch (e) {
      print('Error deleting user has activity: $e');
      _showError('Error deleting user has activity');
    }
  }

  void _associateUserHasActivity(BuildContext context) async {
    final int idUsuario = int.tryParse(_idUsuarioController.text) ?? 0;
    final int idAtividade = int.tryParse(_idAtividadeController.text) ?? 0;
    final double grade = double.tryParse(_gradeController.text) ?? 0.0;
    final String sendDate = _sendDateController.text;

    if (idUsuario <= 0 || idAtividade <= 0 || sendDate.isEmpty) {
      _showError('Please fill required fields');
      return;
    }

    try {
      await UserHasActivitiesService.assignActivityToUser(
          idAtividade, idUsuario, grade, sendDate);

      await _loadUsersHasActivities();

      _idUsuarioController.clear();
      _idAtividadeController.clear();
      _gradeController.clear();
      _sendDateController.clear();
      Navigator.of(context).pop();
    } catch (e) {
      print('Error creating user has activity: $e');
      _showError('Error creating user has activity');
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
          title: Text('Associate Activity with User'),
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
                  controller: _gradeController,
                  decoration: InputDecoration(labelText: 'Grade'),
                ),
                TextFormField(
                  controller: _sendDateController,
                  decoration: InputDecoration(labelText: 'Send Date (YYYY-MM-DD)'),
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
                _associateUserHasActivity(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
