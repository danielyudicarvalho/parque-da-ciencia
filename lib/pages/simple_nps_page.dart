import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pc_app/pages/confirmation_page.dart';

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
    showDialog(
        context: context,
        builder: (context) {
          return const ConfirmationPage();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Applied from HomePage

      appBar: AppBar(
        backgroundColor: const Color(0xFF0088B7), // Applied from HomePage
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
            color: Colors.white, // Applied from HomePage
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 6),
                  TextButton(
                    // Wrap with TextButton for optional text color change
                    onPressed: () {
                      saveNewReview(5);
                      openConfirmationPage();
                    },
                    child: Image.asset('lib/images/feliz.png'),
                  ),
                  const Spacer(flex: 1),
                  TextButton(
                    // Wrap with TextButton for optional text color change
                    onPressed: () {
                      saveNewReview(4);
                      openConfirmationPage();
                    },
                    child: Image.asset('lib/images/meio_feliz.png'),
                  ),
                  const Spacer(flex: 1),
                  TextButton(
                    // Wrap with TextButton for optional text color change
                    onPressed: () {
                      saveNewReview(3);
                      openConfirmationPage();
                    },
                    child: Image.asset('lib/images/medio.png'),
                  ),
                  const Spacer(flex: 1),
                  TextButton(
                    // Wrap with TextButton for optional text color change
                    onPressed: () {
                      saveNewReview(2);
                      openConfirmationPage();
                    },
                    child: Image.asset('lib/images/meio_infeliz.png'),
                  ),
                  const Spacer(flex: 1),
                  TextButton(
                    // Wrap with TextButton for optional text color change
                    onPressed: () {
                      saveNewReview(1);
                      openConfirmationPage();
                    },
                    child: Image.asset('lib/images/infeliz.png'),
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
