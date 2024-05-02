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

  // Function to validate form fields
  bool validateFields() {
    if (serverName.isEmpty || serverEmail.isEmpty || studentCount.isEmpty || schoolName.isEmpty) {
      return false;
    }
    return true;
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0088B7),
        centerTitle: true,
        title: const Text(
          "Iniciando passeio",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8, bottom: 4),
            child: Image.asset(
              'lib/images/logo_vem_p_ufms.png',
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 8, bottom: 4),
            child: Image.asset('lib/images/logo_ufms.png'),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagem da logo do parque
              Image.asset("lib/images/logo_parque.png", width: 300, height: 300),

              // Email field
              TextField(
                onChanged: (text) {
                  serverEmail = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Color(0xFF0088B7)),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // Password field
              TextField(
                onChanged: (text) {
                  serverName = text;
                },
                decoration: const InputDecoration(
                  labelText: "Nome do servidor",
                  labelStyle: TextStyle(color: Color(0xFF0088B7)),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                onChanged: (text) {
                  schoolName = text;
                },
                decoration: const InputDecoration(
                  labelText: "Nome da escola",
                  labelStyle: TextStyle(color: Color(0xFF0088B7)),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                onChanged: (text) {
                  studentCount = text;
                },
                decoration: const InputDecoration(
                  labelText: "Número de estudantes",
                  labelStyle: TextStyle(color: Color(0xFF0088B7)),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              MyButton(
                text: "Entrar",
                onPressed: submitForm,
              ),

              //const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
