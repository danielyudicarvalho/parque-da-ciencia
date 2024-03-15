import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pc_app/pages/question_box.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
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
  void saveNewReview(int score, int reason, String feedback) {
  Review review = Review(
    id: 0,
    score: score,
    reason: reason,
    feedback: feedback,
  ); 
  print("Saved!");
}

openQuestionBox(int score) {
  showDialog(
    context: context,
    builder: (context) {
      return QuestionBox(
        onSave: (int reason, String feedback) {
          saveNewReview(score, reason, feedback); // Updated to include reason and feedback
        },
        onCancel: () {
          Navigator.of(context).pop();
          print("Canceled!");
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
