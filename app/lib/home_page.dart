import 'package:flutter/material.dart';
import 'usuario_screen.dart';
import 'atividades_screen.dart';
import 'usuario_atividades_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Card(
          elevation: 4, 
          margin: EdgeInsets.all(16), 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsuarioScreen()),
                    );
                  },
                  child: Text('Usuario Screen'),
                ),
                SizedBox(height: 16), 
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AtividadesScreen()),
                    );
                  },
                  child: Text('Atividades Screen'),
                ),
                SizedBox(height: 16), 
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsuarioAtividadesScreen()),
                    );
                  },
                  child: Text('Usuario Atividades Screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
