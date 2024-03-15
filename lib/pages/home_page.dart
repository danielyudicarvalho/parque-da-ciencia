import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pc_app/pages/question_box.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:pc_app/review_model.dart';
import 'package:sqflite/sqflite.dart';


// Initialize a database
Future<Database> initDatabase() async {
  final path = join(await getDatabasesPath(), 'database.db');
  return openDatabase(path, onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE review(id INTEGER PRIMARY KEY, score INTEGER, reason INTEGER, feedback STRING)',
    );
  }, version: 1);
}

// Insert data into the database
Future<void> insertData(String name) async {
  final db = await initDatabase();
  await db.insert('my_table', {'name': name});
}

// Query data from the database
Future<List<Map<String, dynamic>>?> fetchData() async {
  final db = await initDatabase();
  return db.query('my_table');
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Methods
  void saveNewReview(){
/*    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();*/
    print("Salvo!");
  }

openQuestionBox(int score){
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBox(
          onSave: saveNewReview,
          onCancel: () {
            Navigator.of(context).pop();
            /*_controller.clear();*/
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
            const Spacer(flex: 2,),
            IconButton(
              onPressed: openQuestionBox(5),
              icon: Image.asset('lib/images/feliz.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox(4),
              icon: Image.asset('lib/images/meiofeliz.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox(3),
              icon: Image.asset('lib/images/medio.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox(2),
              icon: Image.asset('lib/images/meioruim.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox(1),
              icon: Image.asset('lib/images/ruim.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),
            const Spacer(flex: 2,),
          ],
        ),
      ),

    );
  }
}
