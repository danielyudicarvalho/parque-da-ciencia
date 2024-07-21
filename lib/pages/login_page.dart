import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/error_page.dart';
import 'package:pc_app/pages/options_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Define fields based on requirements
  String serverName = '';
  String serverEmail = '';
  String studentCount = '';
  String schoolName = '';
  late Future<Database> _database;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    _openDB();
  }

  // Function to open de app database - contains login informations
  Future<void> _openDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "app.db";

    _database = openDatabase(path);
  }

  // Function to validate form fields
  bool validateFields() {
    if (serverName.isEmpty || studentCount.isEmpty || schoolName.isEmpty) {
      return false;
    }
    return true;
  }

  // Function to validate form fields
  bool validateEmailFields() {
    // Verificação de email
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (serverEmail.isEmpty) {
      return true;
    } else if (!regex.hasMatch(serverEmail)) {
      return false;
    } else
      return true;
  }

  // Function to save form informations about server
  Future<void> _saveFormData() async {
    final db = await _database;
    await db.transaction((txn) async {
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

  void goToOptionsPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OptionPage()),
    );
  }

  void showErrorMessage(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preencha todos os campos corretamente'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showEmailErrorMessage(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Digite um email válido'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Function to handle form submission
  void submitForm() async {
    if (validateFields() && validateEmailFields()) {
      // Process form data (e.g., save to database, navigate)
      await _saveFormData();
      if(serverEmail.isEmpty)
        serverEmail = "dipc.proece@ufms.br";
      goToOptionsPage();
      print("*** EMAIL: ${serverEmail} ***");
    } else if (validateFields() && !validateEmailFields()) {
      showDialog(
          context: context,
          builder: (context) {
            return const ErrorPage(image: 'lib/images/warning.png', frase: 'Email Incorreto!');
          }
      );
      print("*** EMAIL: ${serverEmail} ***");
    } else {
      // Show error message
      showDialog(
          context: context,
          builder: (context) {
            return const ErrorPage(image: 'lib/images/warning.png', frase: 'Campos Incorretos!');
          }
      );
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
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
                  '  Sobre esta Aplicação',
                  style: TextStyle(
                    color: Color(0xFF0088B7),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Desenvolvedores voluntários (Acadêmicos dos cursos da Faculdade de Computação):',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Arthur Henrique - Desenvolvedor Full-Stack 👻',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '(arthur.h.a.farias@ufms.br)',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Daniel Yudi de Carvalho - Desenvolvedor Back-End',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '(daniel@ufms.br)',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),
                    const SizedBox(height: 20),

                    const Text(
                      'João Pedro Rodrigues - Desenvolvedor Front-End',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '(joao_pedro_rodrigues@ufms.br)',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Orientação:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Luciana Montera (Professora da Faculdade de Computação)',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Text(
                            'Fechar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Inicialize o TextEditingController com o e-mail pré-preenchido
  final TextEditingController _emailController =
  TextEditingController(text: 'dipc.proece@ufms.br');

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
                  // Logo image
                  Image.asset(
                    "lib/images/logo_parque.png",
                    width: 265,
                    height: 265,
                  ),

                  // Server name field
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

                  // Campo do email do servidor
                  TextFormField(
                    controller: _emailController,
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

                  // Campo do nome da escola visitante
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

                  // Campo para o numero de estudantes da escola
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

                  // Botao de inicio
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
