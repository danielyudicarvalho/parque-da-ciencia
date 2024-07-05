import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/confirmation_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pc_app/pages/question_box_happy.dart';
import 'package:pc_app/pages/question_box_less_happy.dart';
import 'package:pc_app/pages/question_box_medium.dart';
import 'package:pc_app/pages/question_box_more_bad.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS monitor_reports("
            "id INTEGER PRIMARY KEY, "
            "rating INTEGER, "
            "option1 TEXT, "
            "option2 TEXT, "
            "option3 TEXT, "
            "option4 TEXT, "
            "feedback TEXT)");
      },
      onOpen: (Database db) async {
        await db.execute("CREATE TABLE IF NOT EXISTS monitor_reports("
            "id INTEGER PRIMARY KEY, "
            "rating INTEGER, "
            "option1 TEXT, "
            "option2 TEXT, "
            "option3 TEXT, "
            "option4 TEXT, "
            "feedback TEXT)");
      },
    );
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

  Future<void> saveNewReview(int rating, String option1, String option2,
      String option3, String option4, String feedback) async {
    await _database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO monitor_reports(rating, option1, option2, option3, option4, feedback) VALUES(?, ?, ?, ?, ?, ?)',
        [rating, option1, option2, option3, option4, feedback],
      );
    });
  }

  void openConfirmationPage() {
    showDialog(
      context: context,
      builder: (context) {
        return const ConfirmationPage();
      },
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
          await saveNewReview(5, option1, option2, option3, option4, feedback);
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
          await saveNewReview(4, option1, option2, option3, option4, feedback);
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
          await saveNewReview(3, option1, option2, option3, option4, feedback);
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
      QuestionBoxMoreBad(
        onSave: (option1, option2, option3, option4, feedback) async {
          await saveNewReview(2, option1, option2, option3, option4, feedback);
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
        onSave: (option1, option2, option3, option4, feedback) async {
          await saveNewReview(1, option1, option2, option3, option4, feedback);
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
      body: Stack(
        children: [
          // Gif do capi
          Positioned(
            top: 258,
            right: 920,
            width: 450,
            height: 450,
            child: Image.asset("lib/images/capi_movimento.gif"),
          ),
          // Gif do balão
          Positioned(
            top: 25,
            right: 810,
            width: 280,
            height: 280,
            child: Image.asset("lib/images/balao_mov.gif"),
          ),
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
          Positioned(
            top: 490,
            right: 16,
            child: Image.asset(
              'lib/images/logo_parque.png',
              width: 230,
              height: 230,
            ),
          ),
        ],
      ),
    );
  }
}
