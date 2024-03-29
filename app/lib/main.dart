import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:app/api_service.dart';

void main() {
  ApiService.initialize('http://localhost:3000');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(), 
    );
  }
}
