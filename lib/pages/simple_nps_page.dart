import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pc_app/pages/confirmation_page.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:pc_app/pages/simple_nps_page.dart';

class SimpleNpsPage extends StatefulWidget {
  const SimpleNpsPage({Key? key});

  @override
  State<SimpleNpsPage> createState() => _SimpleNpsPageState();
}

class _SimpleNpsPageState extends State<SimpleNpsPage> {
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "reports.db";

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE reports(id INTEGER PRIMARY KEY, rating INTEGER)");
    });
  }

  void saveNewReview(int rating) async {
    await _database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO reports(rating) VALUES(?)', [rating]);
    });
  }

  void openConfirmationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ConfirmationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Applied from HomePage
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Applied from HomePage
        centerTitle: true,
        title: const Text(
          "Parque Da Ciência",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white, // Applied from HomePage
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton( // Wrap with TextButton for optional text color change
              onPressed: () {
                saveNewReview(5);
                openConfirmationPage();
              },
              child: Image.asset('lib/images/feliz.png'),
            ),
            TextButton( // Wrap with TextButton for optional text color change
              onPressed: () {
                saveNewReview(4);
                openConfirmationPage();
              },
              child: Image.asset('lib/images/meio_feliz.png'),
            ),
            TextButton( // Wrap with TextButton for optional text color change
              onPressed: () {
                saveNewReview(3);
                openConfirmationPage();
              },
              child: Image.asset('lib/images/medio.png'),
            ),
            TextButton( // Wrap with TextButton for optional text color change
              onPressed: () {
                saveNewReview(2);
                openConfirmationPage();
              },
              child: Image.asset('lib/images/meio_infeliz.png'),
            ),
            TextButton( // Wrap with TextButton for optional text color change
              onPressed: () {
                saveNewReview(1);
                openConfirmationPage();
              },
              child: Image.asset('lib/images/infeliz.png'),
            ),
          ],
        ),
      ),
    );
  }
}
