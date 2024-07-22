import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pc_app/pages/question_box.dart';
import 'package:pc_app/pages/question_box_happy.dart';
import 'package:pc_app/pages/question_box_less_happy.dart';
import 'package:pc_app/pages/question_box_medium.dart';
import 'package:pc_app/pages/question_box_bad.dart';
import 'package:pc_app/pages/question_box_more_bad.dart';

import 'generic_pop_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Database> _database;
  List<Map<String, dynamic>> _reviews = [];

  @override
  void initState() {
    super.initState();
    _openDB();
  }

  // Function to open de app database - contains reviews information
  Future<void> _openDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "reports.db";

    _database = openDatabase(path);
  }


  saveNewReview(int rating, String option1,String option2,String option3,String option4, String feedback) async {
    final db = await _database;
    await db.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO monitor_reports(rating, option1, option2, option3, option4, feedback) VALUES(?, ?, ?, ?, ?, ?)',
        [rating, option1,option2,option3,option4, feedback],
      );
    });
  }

  void openConfirmationPage() {
    showDialog(
      context: context,
      builder: (context) {
        return const GenericPopUp(image: "lib/images/logo_parque_transp.png", frase: "Obrigado pelo seu feedback!");
      }
    );
  }

  void _openQuestionBox(int rating, Widget dialogWidget) {
    showDialog(
      context: context,
      builder: (context) => dialogWidget,
    );
  }

  void openQuestionBoxHappy() {
    _openQuestionBox(
      5,
      QuestionBoxHappy(
        onSave: (option1, option2, option3, option4, feedback) async {
          await saveNewReview(5, option1,option2, option3, option4, feedback);
          openConfirmationPage();
        },
        onCancel: () {
          Navigator.of(context).pop();
          print("Cancelado!");
        },
      ),
    );
  }

  void openQuestionBoxLessHappy() {
    _openQuestionBox(
      4,
      QuestionBoxLessHappy(
        onSave: (option1, option2, option3, option4, feedback) async {
          await saveNewReview(4, option1,option2, option3, option4, feedback);
          openConfirmationPage();
        },
        onCancel: () {
          Navigator.of(context).pop();
          print("Cancelado!");
        },
      ),
    );
  }

  void openQuestionBoxMedium() {
    _openQuestionBox(
      3,
      QuestionBoxMedium(
        onSave: (option1, option2, option3, option4, feedback) async {
          await saveNewReview(3, option1,option2, option3, option4, feedback);
          openConfirmationPage();
        },
        onCancel: () {
          Navigator.of(context).pop();
          print("Cancelado!");
        },
      ),
    );
  }

  void openQuestionBoxBad() {
    _openQuestionBox(
      2,
      QuestionBoxBad(
        onSave: (option1, option2, option3, option4, feedback) async {
          await saveNewReview(2, option1,option2, option3, option4, feedback);
          openConfirmationPage();
        },
        onCancel: () {
          Navigator.of(context).pop();
          print("Cancelado!");
        },
      ),
    );
  }

  void openQuestionBoxMoreBad() {
    _openQuestionBox(
      1,
      QuestionBoxMoreBad(
        onSave: (option1,option2, option3, option4, feedback) async {
          await saveNewReview(1, option1, option2,option3, option4, feedback);
          openConfirmationPage();
        },
        onCancel: () {
          Navigator.of(context).pop();
          print("Cancelado!");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0088B7),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
            child: Image.asset(
              'lib/images/logo_ufms.png',
              width: 95,
              height: 95,
            ),
          )
        ],
      ),
      body: Stack(children: [
        // Gif do capi
        Positioned(
            top: 258, // ajuste a posição vertical conforme necessário
            right: 920, // ajuste a posição horizontal conforme necessário
            width: 450, // largura da imagem
            height: 450, // altura da imagem
            child: Image.asset("lib/images/capi_movimento.gif")),

        // Gif do balão
        Positioned(
            top: 25, // ajuste a posição vertical conforme necessário
            right: 810, // ajuste a posição horizontal conforme necessário
            width: 280, // largura da imagem
            height: 280, // altura da imagem
            child: Image.asset("lib/images/balao_mov.gif")),

          Center(
            child: Column(
              children: [
                const Spacer(flex: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(flex: 6),
                    IconButton(
                      onPressed: openQuestionBoxHappy,
                      icon: Image.asset('lib/images/feliz.png'),
                    ),
                    const Spacer(flex: 1),
                    IconButton(
                      onPressed: openQuestionBoxLessHappy,
                      icon: Image.asset('lib/images/meio_feliz.png'),
                    ),
                    const Spacer(flex: 1),
                    IconButton(
                      onPressed: openQuestionBoxMedium,
                      icon: Image.asset('lib/images/medio.png'),
                    ),
                    const Spacer(flex: 1),
                    IconButton(
                      onPressed: openQuestionBoxBad,
                      icon: Image.asset('lib/images/meio_infeliz.png'),
                    ),
                    const Spacer(flex: 1),
                    IconButton(
                      onPressed: openQuestionBoxMoreBad,
                      icon: Image.asset('lib/images/infeliz.png'),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 60),
                const Spacer(),
              ],
            ),
          ),

          /* Icones de logo */
          Positioned(
            top: 490, // ajuste a posição vertical conforme necessário
            right: 16, // ajuste a posição horizontal conforme necessário
            child: Image.asset(
              'lib/images/logo_parque.png',
              width: 230, // ajuste o tamanho da imagem conforme necessário
              height: 230,
            ),
          ),
        ],
      ),
    );
  }
}
