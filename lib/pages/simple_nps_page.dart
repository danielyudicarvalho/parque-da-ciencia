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

    print('review saved');
  }

  void openConfirmationPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ConfirmationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Parque Da Ciência",
          style: TextStyle(
            fontSize: 30,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                saveNewReview(5);
                openConfirmationPage();
              },
              icon: Image.asset('lib/images/feliz.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            IconButton(
              onPressed: () {
                saveNewReview(4);
                openConfirmationPage();
              },
              icon: Image.asset('lib/images/meiofeliz.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            IconButton(
              onPressed: () {
                saveNewReview(3);
                openConfirmationPage();
              },
              icon: Image.asset('lib/images/medio.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            IconButton(
              onPressed: () {
                saveNewReview(2);
                openConfirmationPage();
              },
              icon: Image.asset('lib/images/meioruim.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            IconButton(
              onPressed: () {
                saveNewReview(1);
                openConfirmationPage();
              },
              icon: Image.asset('lib/images/ruim.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
          ],
        ),
      ),
    );
  }
}
