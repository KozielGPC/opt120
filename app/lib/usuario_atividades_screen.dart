import 'package:flutter/material.dart';

class UsuarioAtividadesScreen extends StatefulWidget {
  @override
  _UsuarioAtividadesScreenState createState() =>
      _UsuarioAtividadesScreenState();
}

class _UsuarioAtividadesScreenState extends State<UsuarioAtividadesScreen> {
  final TextEditingController _idUsuarioController = TextEditingController();
  final TextEditingController _idAtividadeController = TextEditingController();
  final TextEditingController _notaUsuarioController = TextEditingController();
  final TextEditingController _dataEntregaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Associate Usuario with Atividade'),
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
                        controller: _idUsuarioController,
                        decoration: InputDecoration(labelText: 'ID Usuario'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: _idAtividadeController,
                        decoration: InputDecoration(labelText: 'ID Atividade'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: _notaUsuarioController,
                        decoration: InputDecoration(labelText: 'Nota Usuario'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: _dataEntregaController,
                        decoration: InputDecoration(
                            labelText: 'Data Entrega (YYYY-MM-DD)'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _associateUsuarioAtividade();
                        },
                        child: Text('Associate'),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  void _associateUsuarioAtividade() {
    final int idUsuario = int.tryParse(_idUsuarioController.text) ?? 0;
    final int idAtividade = int.tryParse(_idAtividadeController.text) ?? 0;
    final double notaUsuario =
        double.tryParse(_notaUsuarioController.text) ?? 0.0;
    final String dataEntrega = _dataEntregaController.text;

    if (idUsuario <= 0 || idAtividade <= 0 || dataEntrega.isEmpty) {
      _showError('Please fill required fields');
      return;
    }

    print('ID Usuario: $idUsuario');
    print('ID Atividade: $idAtividade');
    print('Nota Usuario: $notaUsuario');
    print('Data Entrega: $dataEntrega');

    _idUsuarioController.clear();
    _idAtividadeController.clear();
    _notaUsuarioController.clear();
    _dataEntregaController.clear();

    _showSuccess('Usuario and Atividade associated successfully');
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
