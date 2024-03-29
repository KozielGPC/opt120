import 'package:flutter/material.dart';
import 'package:app/data_table_widget.dart'; // Import the DataTableWidget
import 'package:app/user_service.dart'; // Import the UserService or wherever you fetch user data from

class UsuarioScreen extends StatefulWidget {
  @override
  _UsuarioScreenState createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  List<List<String>> _userTableData = []; // Data for the table

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Load users when the screen initializes
  }

  Future<void> _loadUsers() async {
    // Fetch user data from the backend
    // For demonstration purposes, let's assume UserService.getUserList() returns a list of users
    final userList = await UserService.getUserList();

    setState(() {
      _userTableData = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
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
                DataTableWidget( // Display the table of users
                  fieldNames: ['Name', 'Email'],
                  inputData: _userTableData,
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
                _createUsuario(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _createUsuario(BuildContext context) async {
    final String nome = _nomeController.text;
    final String email = _emailController.text;
    final String senha = _senhaController.text;

    // Call the UserService to create the user
    try {
      await UserService.createUser(nome, email, senha);
      // Reload users after creating the new user
      await _loadUsers();
      // Clear input fields
      _nomeController.clear();
      _emailController.clear();
      _senhaController.clear();
      Navigator.of(context).pop(); // Close the modal
    } catch (e) {
      // Handle error
      print('Error creating user: $e');
    }
  }
}
