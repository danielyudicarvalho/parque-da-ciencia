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
    String path = documentsDirectory.path + "/" + "reports.db";

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE reports(id INTEGER PRIMARY KEY, rating INTEGER)");
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

  saveNewReview(int rating) async {
    await _database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO reports(rating) VALUES(?)', [rating]);
    });
  }

  void openConfirmationPage() {
    showDialog(
        context: context,
        builder: (context) {
          return const ConfirmationPage();
        });
  }

  void openQuestionBoxHappy() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBoxHappy(
          onSave: () async {
            await saveNewReview(5);
            openConfirmationPage();
          }, //saveNewReview(5, true),
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
          onSave: () async {
            await saveNewReview(4);
            openConfirmationPage();
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
          onSave: () async {
            await saveNewReview(3);
            openConfirmationPage();
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
          onSave: () async {
            await saveNewReview(2);
            openConfirmationPage();
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
          onSave: () async {
            await saveNewReview(1);
            openConfirmationPage();
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
              const Spacer(
                flex: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
              const SizedBox(
                height: 60,
              ),
              const Spacer()
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
      ]),
    );
  }
}
