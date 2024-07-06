import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/home_page.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path + "/" + "app.db";
  String path2 = documentsDirectory.path + "/" + "reports.db";

  // Iniciando o banco de dados para armazenar as informações de login, no arquivo app.db
  final appDatabase = openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS login_info(id INTEGER PRIMARY KEY, server_name TEXT, server_email TEXT, student_count TEXT, school_name TEXT)',);
      }
  );

  // Iniciando o banco de dados para armazenar as informações de avaliação, no arquivo reports.db
  final reportsDatabase = openDatabase(
      path2,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS monitor_reports(id INTEGER PRIMARY KEY, rating INTEGER, option1 TEXT, option2 TEXT, option3 TEXT, option4 TEXT, feedback TEXT)");
        await db.execute("CREATE TABLE IF NOT EXISTS reports(id INTEGER PRIMARY KEY, rating INTEGER)");
      },
      onOpen: (Database db) async {
        print("bd aberto!");
      }
  );

  runApp(const PCApp());
}

class PCApp extends StatelessWidget {
  const PCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
