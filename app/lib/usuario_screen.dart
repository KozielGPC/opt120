import 'package:flutter/material.dart';
import 'package:app/data_table_widget.dart';
import 'package:app/user_service.dart';

class UsuarioScreen extends StatefulWidget {
  @override
  _UsuarioScreenState createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  List<List<String>> _userTableData = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final userList = await UserService.getUserList();

    setState(() {
      _userTableData = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
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
                        'User List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showCreateUserModal(context);
                        },
                        child: Text('Create User'),
                      ),
                    ],
                  ),
                ),
                DataTableWidget(
                  fieldNames: ['ID', 'Name', 'Email'],
                  inputData: _userTableData,
                  deleteRow: (index) {
                    _deleteUser(context, index);
                  },
                  updateRow: (index) {
                    // Update row logic here
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

  void _showCreateUserModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create User'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
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
                _createUser(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _createUser(BuildContext context) async {
    final String nome = _nomeController.text;
    final String email = _emailController.text;
    final String senha = _senhaController.text;

    try {
      await UserService.createUser(nome, email, senha);
      
      
      _nomeController.clear();
      _emailController.clear();
      _senhaController.clear();
      Navigator.of(context).pop(); 
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  void _deleteUser(BuildContext context, int index) async {
    try {
      final user = _userTableData[index];
      await UserService.deleteUser(user[0]);
      _userTableData.removeAt(index);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User deleted successfully'),
        ),
      );

      setState(() {
        _userTableData = _userTableData;
      });

    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
