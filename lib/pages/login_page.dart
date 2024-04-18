import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/options_page.dart';
import 'package:pc_app/util/my_button.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Define fields based on requirements
  String serverName = '';
  String serverEmail = '';
  String studentCount = '';
  String schoolName = '';

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "app.db";
    _database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE login_info(id INTEGER PRIMARY KEY, server_name TEXT, server_email TEXT, student_count TEXT, school_name TEXT)',
        );
      },
      version: 1,
    );
  }

  Database? _database; // Database instance

  // Function to validate form fields (implement your logic here)
  bool validateFields() {
    // Add checks for each field (e.g., not empty, valid format)
    return true; // Replace with your validation logic
  }

  Future<void> _saveFormData() async {
    await _database!.transaction((txn) async {
      await txn.delete('login_info');
      final data = <String, dynamic>{
        'server_name': serverName,
        'server_email': serverEmail,
        'student_count': studentCount,
        'school_name': schoolName,
      };
      await txn.insert('login_info', data);
    });
  }

  // Function to handle form submission
  void submitForm() async {
    if (validateFields()) {
      // Process form data (e.g., save to database, navigate)
      await _saveFormData();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OptionPage()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Preencha todos os campos corretamente'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Iniciando passeio",
          style: TextStyle(
            fontSize: 30,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Server name field
            TextField(
              onChanged: (text) {
                serverName = text;
              },
              decoration: const InputDecoration(
                labelText: "Nome do servidor UFMS",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Server email field
            TextField(
              onChanged: (text) {
                serverEmail = text;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email do servidor",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Student count field
            TextField(
              onChanged: (text) {
                studentCount = text;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantidade de alunos",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // School name field
            TextField(
              onChanged: (text) {
                schoolName = text;
              },
              decoration: const InputDecoration(
                labelText: "Nome da escola",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            MyButton(
              text: "Enviar",
              onPressed: submitForm,
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
