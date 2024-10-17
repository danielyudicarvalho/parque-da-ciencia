import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/complex_nps_page.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the application documents directory
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path + "/" + "app.db";
  String path2 = documentsDirectory.path + "/" + "reports.db";

  // Delete the existing database files
  try {
    final File appDbFile = File(path);
    if (await appDbFile.exists()) {
      await appDbFile.delete();
    }
  } catch (e) {
    print("Error deleting app database file: $e");
  }

  try {
    final File reportsDbFile = File(path2);
    if (await reportsDbFile.exists()) {
      await reportsDbFile.delete();
    }
  } catch (e) {
    print("Error deleting reports database file: $e");
  }

  // Initialize the app database for storing login information
  final appDatabase = openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE login_info (
          id INTEGER PRIMARY KEY,
          server_name TEXT,
          server_email TEXT,
          student_count TEXT,
          school_name TEXT,
          min_age TEXT,
          max_age TEXT,
          city TEXT,
          district TEXT
        )
      ''');
    },
  );

  // Initialize the reports database for storing evaluation information
  final reportsDatabase = openDatabase(
    path2,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE monitor_reports (
          id INTEGER PRIMARY KEY,
          rating INTEGER,
          option1 TEXT,
          option2 TEXT,
          option3 TEXT,
          option4 TEXT,
          feedback TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE reports (
          id INTEGER PRIMARY KEY,
          rating INTEGER
        )
      ''');
    },
    onOpen: (Database db) async {
      print("Reports database opened!");
    },
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
