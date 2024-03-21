import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'review_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
       return db.execute(
      'CREATE TABLE review(id INTEGER PRIMARY KEY, score INTEGER, reason INTEGER, feedback STRING)',
    );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
Future<void> insertReview(Review review) async {
  // Get a reference to the database.
  final db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'reviews',
    review.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Review>> reviews() async {
  // Get a reference to the database.
  final db = await database;
    // Query the table for all the dogs.
  final List<Map<String, Object?>> reviewMaps = await db.query('dogs');

  // Convert the list of each dog's fields into a list of `Dog` objects.
  return [
    for (final {
          'id': id as int,
          'score': score as int,
          'reason': reason as String,
          'feedback': feedback as String,
        } in reviewMaps)
      Review(id: id, score: score, reason: reason, feedback: feedback),
  ];}

  Future<void> updateReview(Review review) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'reviews',
      review.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [review.id],
    );
  }

  Future<void> deleteReview(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'reviews',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table


  // Now, use the method above to retrieve all the dogs.
 
}

class Review {
  final int id;
  final int score;
  final String reason;
  final String feedback;

  const Review({
    required this.id,
    required this.score,
    required this.reason,
    required this.feedback
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'score': score,
      'reason': reason,
      'feedback': feedback
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Review{id: $id, score: $score, reason: $reason, feedback: $feedback}';
  }
}
