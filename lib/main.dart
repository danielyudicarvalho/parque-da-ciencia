import 'package:flutter/material.dart';
import 'package:pc_app/pages/home_page.dart';

void main() {
  runApp(const PCApp());
}

class PCApp extends StatelessWidget {
  const PCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: Colors.blue, // Definindo a cor primária como azul
      ),
    );
  }
}
