import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/options_page.dart';
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
    if (serverName.isEmpty ||
        serverEmail.isEmpty ||
        studentCount.isEmpty ||
        schoolName.isEmpty) {
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

  void goToOptionsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OptionPage()),
    );
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preencha todos os campos corretamente'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Function to handle form submission
  void submitForm() async {
    if (validateFields()) {
      // Process form data (e.g., save to database, navigate)
      await _saveFormData();
      goToOptionsPage();
    } else {
      // Show error message
      showErrorMessage();
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Desenvolvido pelos seguintes alunos da FACOM:',
              style: TextStyle(
                color: Color(0xFF0088B7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0088B7),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Arthur Henrique - Desenvolvedor Full-Stack 👻',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 5),
                const Text(
                  '(arthur.h.a.farias@ufms.br)',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 20),
                const Text(
                  'João Pedro Rodrigues - Desenvolvedor Front-End',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 5),
                const Text(
                  '(joao_pedro_rodrigues@ufms.br)',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Daniel Yudi de Carvalho - Desenvolvedor Back-End',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 5),
                const Text(
                  '(daniel@ufms.br)',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text('Fechar',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0088B7),
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          color: Colors.white,
          onPressed: _showAboutDialog,
        ),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/images/logo_parque.png",
                    width: 265,
                    height: 265,
                  ),
                  TextField(
                    onChanged: (text) {
                      serverName = text;
                    },
                    decoration: const InputDecoration(
                      labelText: "Nome do Servidor Responsável",
                      labelStyle: TextStyle(color: Color(0xFF0088B7)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      serverEmail = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email do Servidor Responsável",
                      labelStyle: TextStyle(color: Color(0xFF0088B7)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      schoolName = text;
                    },
                    decoration: const InputDecoration(
                      labelText: "Nome da Escola Visitante",
                      labelStyle: TextStyle(color: Color(0xFF0088B7)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      studentCount = text;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número de Estudantes da Visita",
                      labelStyle: TextStyle(color: Color(0xFF0088B7)),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: const Color(0xFF0088B7),
                    ),
                    child: const Text(
                      'Iniciar',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
