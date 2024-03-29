import 'package:flutter/material.dart';

class UsuarioScreen extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Usuario'),
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
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _createUsuario(context);
                    },
                    child: Text('Create Usuario'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _createUsuario(BuildContext context) {
    final String nome = _nomeController.text;
    final String email = _emailController.text;
    final String senha = _senhaController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      _showError(context, 'Please fill all fields');
      return;
    }

    print('Nome: $nome');
    print('Email: $email');
    print('Senha: $senha');

    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();

    _showSuccess(context, 'Usuario created successfully');
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
