import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pc_app/pages/question_box.dart';
import 'package:pc_app/pages/question_box_happy.dart';
import 'package:pc_app/pages/question_box_less_happy.dart';
import 'package:pc_app/pages/question_box_medium.dart';
import 'package:pc_app/pages/question_box_bad.dart';
import 'package:pc_app/pages/question_box_more_bad.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "reviews.db";

    //String path = join(documentsDirectory.path, "reviews.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE reviews(id INTEGER PRIMARY KEY, review TEXT, isPositive INTEGER)");
    });
  }

  saveNewReview(int review, bool isPositive) async {
    await _database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO reviews(review, isPositive) VALUES(?, ?)',
          [review, isPositive ? 1 : 0]);
    });
    print("Salvo!");
  }

  

  void openQuestionBox() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBox(
          onSave: saveNewReview(5, true),
          onCancel: () {
            Navigator.of(context).pop();
            print("Cancelado!");
          },
        );
      },
    );
  }

  void openQuestionBoxHappy() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBoxHappy(
          onSave: () async{
            await saveNewReview(5, true);
          },//saveNewReview(5, true),
          onCancel: () {
            Navigator.of(context).pop();
            print("Cancelado!");
          },
        );
      },
    );
  }

  void openQuestionBoxLessHappy() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBoxLessHappy(
          onSave: () async{
            await saveNewReview(5, true);
          },
          onCancel: () {
            Navigator.of(context).pop();
            print("Cancelado!");
          },
        );
      },
    );
  }

  void openQuestionBoxMedium() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBoxMedium(
          onSave: () async{
            await saveNewReview(5, true);
          },
          onCancel: () {
            Navigator.of(context).pop();
            print("Cancelado!");
          },
        );
      },
    );
  }

  void openQuestionBoxBad() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBoxBad(
          onSave: () async{
            await saveNewReview(5, true);
          },
          onCancel: () {
            Navigator.of(context).pop();
            print("Cancelado!");
          },
        );
      },
    );
  }

  void openQuestionBoxMoreBad() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBoxMoreBad(
          onSave: () async{
            await saveNewReview(5, true);
          },
          onCancel: () {
            Navigator.of(context).pop();
            print("Cancelado!");
          },
        );
      },
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
            const Spacer(flex: 2),
            IconButton(
              onPressed: () => openQuestionBoxHappy(),
              icon: Image.asset('lib/images/feliz.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            const Spacer(flex: 1),
            IconButton(
              onPressed: () => openQuestionBoxLessHappy(),
              icon: Image.asset('lib/images/meiofeliz.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            const Spacer(flex: 1),
            IconButton(
              onPressed: () => openQuestionBoxMedium(),
              icon: Image.asset('lib/images/medio.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            const Spacer(flex: 1),
            IconButton(
              onPressed: () => openQuestionBoxBad(),
              icon: Image.asset('lib/images/meioruim.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            const Spacer(flex: 1),
            IconButton(
              onPressed: () => openQuestionBoxMoreBad(),
              icon: Image.asset('lib/images/ruim.jpeg'),
              iconSize: 100,
              padding: EdgeInsets.all(25),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
