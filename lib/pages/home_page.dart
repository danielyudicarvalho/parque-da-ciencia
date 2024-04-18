import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/complex_confirmation_page.dart';
import 'package:pc_app/pages/confirmation_page.dart';
import 'package:pc_app/pages/login_page.dart';
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
  List<Map<String, dynamic>> _reviews = [];

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

  Future<List<Map<String, dynamic>>> _getReviews() async {
    final List<Map<String, dynamic>> reviews =
        await _database.rawQuery('SELECT * FROM reviews');
    return reviews;
  }


  Future<void> _retrieveReviews() async {
    final List<Map<String, dynamic>> reviews =
        await _database.rawQuery('SELECT * FROM reviews');
    setState(() {
      _reviews = reviews;
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
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ComplexConfirmationPage()),
          );
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
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ComplexConfirmationPage()),
          );
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
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ComplexConfirmationPage()),
          );
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
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ComplexConfirmationPage()),
          );
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
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ComplexConfirmationPage()),
          );
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
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0088B7),
        centerTitle: true,
        title: const Text(
          "Conta Pra Gente!",
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
            padding: const EdgeInsets.only(right: 10, bottom: 4),
            child: Image.asset('lib/images/logo_ufms.png', width: 95, height: 95,),
          )
        ],
      ),

      body: Stack(
        children: [
          Positioned(
            top: 235, // ajuste a posição vertical conforme necessário
            right: 950, // ajuste a posição horizontal conforme necessário
            width: 400, // largura da imagem
            height: 400, // altura da imagem
            child: Image.asset("lib/images/capi_movimento.gif")
          ),
          Positioned(
            top: 10, // ajuste a posição vertical conforme necessário
            right: 820, // ajuste a posição horizontal conforme necessário
            width: 280, // largura da imagem
            height: 280, // altura da imagem
            child: Image.asset("lib/images/balao_mov.gif")
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 6),

                IconButton(
                  onPressed: () => openQuestionBoxHappy(),
                  icon: Image.asset('lib/images/feliz.png'),
                ),

                const Spacer(flex: 1),

                IconButton(
                  onPressed: () => openQuestionBoxLessHappy(),
                  icon: Image.asset('lib/images/meio_feliz.png'),
                ),

                const Spacer(flex: 1),

                IconButton(
                  onPressed: () => openQuestionBoxMedium(),
                  icon: Image.asset('lib/images/medio.png'),
                ),

                const Spacer(flex: 1),

                IconButton(
                  onPressed: () => openQuestionBoxBad(),
                  icon: Image.asset('lib/images/meio_infeliz.png'),
                ),

                const Spacer(flex: 1),

                IconButton(
                  onPressed: () => openQuestionBoxMoreBad(),
                  icon: Image.asset('lib/images/infeliz.png'),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),


          /* Icones de logo */

          Positioned(
            top: 500, // ajuste a posição vertical conforme necessário
            right: 16, // ajuste a posição horizontal conforme necessário
            child: Image.asset(
              'lib/images/logo_parque.png',
              width: 210, // ajuste o tamanho da imagem conforme necessário
              height: 210,
            ),
          ),
        ]
      ),
    );
  }
}