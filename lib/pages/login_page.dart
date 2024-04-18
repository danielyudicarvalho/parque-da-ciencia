import 'package:flutter/material.dart';
import 'package:pc_app/pages/home_page.dart';
import 'package:pc_app/pages/options_page.dart';
import 'package:pc_app/pages/simple_nps_page.dart';
import 'package:pc_app/util/my_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Strings to store email and password
  String email = '';
  String password = '';

  // Function to validate email and password
  bool validateEmailAndPassword(String email, String password) {
    // Basic email validation
    final emailRegExp =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }

    // Password validation (for example, length check)
    if (password.length < 6) {
      return false;
    }

    // If both email and password are valid, return true
    return true;
  }

  // Function to open the database
  Future<Database> _openDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "emails.db";

    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE emails(id INTEGER PRIMARY KEY, email TEXT)");
        });
  }

  // Function to save email to the database
  Future<void> _saveEmailToDatabase(String email) async {
    final Database database = await _openDatabase();

    // Delete all existing emails
    await database.delete('emails');

    // Insert the new email
    await database.insert('emails', {'email': email});
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
          "Login",
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagem da logo do parque
                    Image.asset("lib/images/logo_parque.png", width: 300, height: 300),

                    // Email field
                    TextField(
                      onChanged: (text) {
                        email = text;
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
                        password = text;
                      },
                      obscureText: true, // Hide password characters
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Color(0xFF0088B7)),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 50),

                    MyButton(
                      text: "Entrar",
                      onPressed: () async {
                        // Validate email and password
                        if (validateEmailAndPassword(email, password)) {
                          // Save email to database
                          await _saveEmailToDatabase(email);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OptionPage()),
                          );
                        } else {
                          // Show a SnackBar or Dialog with an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Email ou senha inválidos'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),

                    //const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
