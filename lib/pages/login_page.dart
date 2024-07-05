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
  String serverName = '';
  String serverEmail = '';
  String studentCount = '';
  String schoolName = '';
  Database? _database;

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
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS login_info('
            'id INTEGER PRIMARY KEY, '
            'server_name TEXT, '
            'server_email TEXT, '
            'student_count TEXT, '
            'school_name TEXT)');
        await db.execute("CREATE TABLE IF NOT EXISTS monitor_reports("
            "id INTEGER PRIMARY KEY, "
            "rating INTEGER, "
            "option1 TEXT, "
            "option2 TEXT, "
            "option3 TEXT, "
            "option4 TEXT, "
            "feedback TEXT)");
      },
    );
  }

  bool validateFields() {
    return serverName.isNotEmpty &&
        serverEmail.isNotEmpty &&
        studentCount.isNotEmpty &&
        schoolName.isNotEmpty;
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

  void submitForm() async {
    if (validateFields()) {
      await _saveFormData();
      goToOptionsPage();
    } else {
      showErrorMessage();
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/images/logo_parque.png",
                  width: 265, height: 265),
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
      ),
    );
  }
}
