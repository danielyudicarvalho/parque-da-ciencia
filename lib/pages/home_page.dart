import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pc_app/pages/question_box.dart';

import 'dart:async';

import 'package:flutter/src/widgets/navigator.dart';
import 'package:path/path.dart';
import 'package:pc_app/review_model.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Methods
  void saveNewReview(int score, String reason, String feedback) {
    Review review = Review(
      id: 0,
      score: score,
      reason: reason,
      feedback: feedback,
    );
    print("Saved!");
  }

  openQuestionBox(int score, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionBox(
          onSave: (String reason, String feedback) {
            saveNewReview(score, reason,
                feedback); // Updated to include reason and feedback
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
            print("Canceled!");
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
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          "Parque Da Ciência",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            IconButton(
              onPressed: () {
                Future.microtask(() {
                  openQuestionBox(5, context);
                });
              },
              icon: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  child: Image.asset('lib/images/feliz.jpeg'),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(5)),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            IconButton(
              onPressed: () {
                Future.microtask(() {
                  openQuestionBox(4, context);
                });
              },
              icon: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  child: Image.asset('lib/images/meiofeliz.jpeg'),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(5)),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            IconButton(
              onPressed: () {
                Future.microtask(() {
                  openQuestionBox(3, context);
                });
              },
              icon: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  child: Image.asset('lib/images/medio.jpeg'),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(5)),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            IconButton(
              onPressed: () {
                Future.microtask(() {
                  openQuestionBox(2, context);
                });
              },
              icon: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  child: Image.asset('lib/images/meioruim.jpeg'),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(5)),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            IconButton(
              onPressed: () {
                Future.microtask(() {
                  openQuestionBox(1, context);
                });
              },
              icon: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  child: Image.asset('lib/images/ruim.jpeg'),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(5)),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
