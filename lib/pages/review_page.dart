import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'review_list.dart'; // Import ReviewList widget

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late Future<List<Map<String, dynamic>>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _reviewsFuture = _getReviews();
  }

  Future<List<Map<String, dynamic>>> _getReviews() async {
    final database = await _openDatabase();
    final reviews = await database.rawQuery('SELECT * FROM reviews');
    return reviews;
  }

  Future<Database> _openDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/reviews.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE reviews(id INTEGER PRIMARY KEY, review TEXT, isPositive INTEGER)");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _reviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final reviews = snapshot.data!;
            return ReviewList(reviews: reviews); // Pass reviews to ReviewList
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Display a loading indicator while fetching data
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
