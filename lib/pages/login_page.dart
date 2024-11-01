import 'dart:convert'; // Import to use jsonEncode
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/generic_pop_up.dart';
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
  String city = '';
  String district = ''; // Cidade/Bairro da escola visitante
  late Future<Database> _database;

  // Age range options
  List<String> ageRanges = [
    '5 a 10 anos',
    '10 a 18 anos',
    '18 a 30 anos',
    '30 a 40 anos',
    '40+'
  ];
  List<bool> selectedAgeRanges = [false, false, false, false, false];

  // Function to validate form fields
  bool validateFields() {
    if (serverName.isEmpty ||
        studentCount.isEmpty ||
        schoolName.isEmpty ||
        city.isEmpty ||
        !selectedAgeRanges.contains(true) ||
        district.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    _openDB();
  }

  // Function to open the app database - contains login information
  Future<void> _openDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "app.db";

    _database = openDatabase(path);
  }

  // Function to validate email field
  bool validateEmailFields() {
    // Email validation
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (serverEmail.isEmpty) {
      return true;
    } else if (!regex.hasMatch(serverEmail)) {
      return false;
    } else {
      return true;
    }
  }

Future<void> _saveFormData() async {
  final db = await _database;

  // Convert selected age ranges to a JSON string
  List<String> selectedRanges = [];
  for (int i = 0; i < selectedAgeRanges.length; i++) {
    if (selectedAgeRanges[i]) {
      selectedRanges.add(ageRanges[i]);
    }
  }
  String ageRangesString = jsonEncode(selectedRanges);

  final data = <String, dynamic>{
    'id': 1, // Assuming a single entry for login info, with ID 1
    'server_name': serverName,
    'server_email': serverEmail,
    'student_count': studentCount,
    'school_name': schoolName,
    'age_ranges': ageRangesString,
    'city': city,
    'district': district
  };

  try {
    await db.insert(
      'login_info',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if it exists
    );
  } catch (e) {
    print('Error inserting data: $e');
  }
}


  void goToOptionsPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OptionPage()),
    );
  }

  // Function to handle form submission
  void submitForm() async {
    if (validateFields() && validateEmailFields()) {
      // Process form data (e.g., save to database, navigate)
      await _saveFormData();
      if (serverEmail.isEmpty) serverEmail = "dipc.proece@ufms.br";
      goToOptionsPage();
      print("*** EMAIL: $serverEmail ***");
    } else if (validateFields() && !validateEmailFields()) {
      showDialog(
          context: context,
          builder: (context) {
            return const GenericPopUp(
                image: 'lib/images/warning.png', frase: 'Email Incorreto!');
          });
      print("*** EMAIL: $serverEmail ***");
    } else {
      // Show error message
      showDialog(
          context: context,
          builder: (context) {
            return const GenericPopUp(
                image: 'lib/images/warning.png', frase: 'Campos Incorretos!');
          });
    }
  }

  // Initialize the TextEditingController with pre-filled email
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

                  // Server email field
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

                  // Visitor school name field
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

                  // Student count field
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

                  const SizedBox(height: 10),

                  // City field
                  TextField(
                    onChanged: (text) {
                      city = text;
                    },
                    decoration: const InputDecoration(
                      labelText: "Cidade da escola visitante",
                      labelStyle: TextStyle(color: Color(0xFF0088B7)),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // District field
                  TextField(
                    onChanged: (text) {
                      district = text;
                    },
                    decoration: const InputDecoration(
                      labelText: "Bairro da escola visitante",
                      labelStyle: TextStyle(color: Color(0xFF0088B7)),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Age range selection
                  // Age range selection with label
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Faixa Etária', // This is the field name label for the age range options
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0088B7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: List.generate(ageRanges.length, (index) {
                          return CheckboxListTile(
                            title: Text(ageRanges[index]),
                            value: selectedAgeRanges[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedAgeRanges[index] = value!;
                              });
                            },
                            activeColor: const Color(0xFF0088B7),
                          );
                        }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Start button
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

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            title: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0088B7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                '  Sobre esta Aplicação',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                        color: Color(0xFF0088B7),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Arthur Henrique - Desenvolvedor Full-Stack',
                      style: TextStyle(color: Color(0xFF0088B7)),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '(arthur.h.a.farias@ufms.br)',
                      style: TextStyle(color: Color(0xFF0088B7), fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Daniel Yudi de Carvalho - Desenvolvedor Back-End',
                      style: TextStyle(color: Color(0xFF0088B7), fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '(daniel@ufms.br)',
                      style: TextStyle(color: Color(0xFF0088B7), fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),
                    const SizedBox(height: 20),

                    const Text(
                      'João Pedro Rodrigues - Desenvolvedor Front-End',
                      style: TextStyle(color: Color(0xFF0088B7), fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '(joao_pedro_rodrigues@ufms.br)',
                      style: TextStyle(color: Color(0xFF0088B7), fontSize: 14),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Orientação:',
                      style: TextStyle(
                        color: Color(0xFF0088B7),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Luciana Montera (Professora da Faculdade de Computação)',
                      style: TextStyle(color: Color(0xFF0088B7)),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 4),
                    // Adicionando a imagem da Fundect
                    Center(
                      child: Image.asset(
                        'lib/images/logo_fundect.png',
                        width: 300,
                        height: 250,
                      ),
                    ),

                    const SizedBox(height: 8),
                    // Adicionando a frase de agradecimento
                    Center(
                      child: const Text(
                        'A equipe agradece à Fundect pelo apoio',
                        style: TextStyle(
                          color: Color(0xFF0088B7),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Text(
                            'Fechar',
                            style: TextStyle(color: Color(0xFF0088B7)),
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

}
