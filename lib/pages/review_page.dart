import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/end_page.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:pc_app/pages/options_page.dart';

import 'confirmation_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late Future<int> _totalReviewsFuture;
  late Future<Map<String, dynamic>> _emailsFuture;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _totalReviewsFuture = _getTotalReviews();
    _emailsFuture = _getEmails();
  }

  Future<void> sendEmail(String csvPath, String recipient, String emailBody,
      String schoolName, String serverName) async {
    final smtpServer =
        gmail('danielyudicarvalho@gmail.com', 'rkww hvdl qrav fmel');

    final message = Message()
      ..from = Address('danielyudicarvalho@gmail.com', 'Yudi')
      ..recipients.add(recipient)
      ..subject =
          'Resultado $schoolName - $serverName ' // Subject with school name and server name
      ..text = emailBody
      ..attachments.add(FileAttachment(File(csvPath)));

    try {
      await send(message, smtpServer);
      print('Email sent');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  Future<Database> _openDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + "reports.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE reports(id INTEGER PRIMARY KEY, rating INTEGER)");
    });
  }

  Future<int> _getTotalReviews() async {
    final database = await _openDatabase();
    final count = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM reports'),
    );
    print('Count: $count');
    return count ?? 0; // Return 0 if count is null
  }

  Future<Map<String, dynamic>> _getEmails() async {
    final Database database = await _openEmailsDatabase();
    final List<Map<String, dynamic>> maps = await database.query(
      'login_info',
      orderBy: 'id DESC', // Order by id in descending order
      limit: 1, // Limit to fetch only one row
    );
    return maps.isNotEmpty
        ? maps.first
        : {}; // Return the first row or an empty map if no data found
  }

  Future<Database> _openEmailsDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/app.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE login_info(id INTEGER PRIMARY KEY, server_name TEXT, server_email TEXT, student_count TEXT, school_name TEXT)',
      );
    });
  }

  Future<List<Map<String, dynamic>>> _getReviews() async {
    final database = await _openDatabase();
    return await database.query('reports');
  }

  Future<void> _submitForm(
      List<String> emails,
      List<Map<String, dynamic>> reviews,
      Map<String, dynamic> loginInfo) async {
    // Prepare CSV content
    final csvContent = _generateCSV(reviews, loginInfo);

    // Prepare email body
    final emailBody = _generateEmailBody(loginInfo);

    // Extract school name and server name
    final schoolName = loginInfo['school_name'];
    final serverName = loginInfo['server_name'];

    // Save CSV to file
    final csvPath = await _saveCSV(csvContent);

    // Send email to each recipient
    for (var email in emails) {
      try {
        await sendEmail(csvPath, email, emailBody, schoolName,
            serverName); // Pass school name and server name to sendEmail
      } catch (e) {
        print('Error sending email: $e');
      }
    }

    // Delete all reviews from the database
    await _deleteReviews();
  }

  String _generateEmailBody(Map<String, dynamic> loginInfo) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('School Name: ${loginInfo['school_name']}');
    buffer.writeln('Server Name: ${loginInfo['server_name']}');
    buffer.writeln('Study Count: ${loginInfo['student_count']}');
    return buffer.toString();
  }

  String _generateCSV(
      List<Map<String, dynamic>> reviews, Map<String, dynamic> loginInfo) {
    final csvBuffer = StringBuffer();

    // Header row with column labels
    csvBuffer.write(
        'Rating, 1 Star, 2 Star, 3 Star, 4 Star, 5 Star, Server Name, School Name, Student Count\n');

    // Count occurrences of each rating
    final reviewCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in reviews) {
      final rating = review['rating'];
      reviewCounts[rating] = reviewCounts[rating]! + 1;
    }

    // Add data row with counts
    csvBuffer.write(
        'Total, ${reviewCounts[1]}, ${reviewCounts[2]}, ${reviewCounts[3]}, ${reviewCounts[4]}, ${reviewCounts[5]},');

    // Add server name, school name, and student count to the CSV
    csvBuffer.write(
        '${loginInfo['server_name']}, ${loginInfo['school_name']}, ${loginInfo['student_count']}\n');

    return csvBuffer.toString();
  }

  Future<String> _saveCSV(String csvContent) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/reviews.csv';
    final File file = File(filePath);
    await file.writeAsString(csvContent);
    return filePath;
  }

  Future<void> _deleteReviews() async {
    final database = await _openDatabase();
    await database.delete('reports');
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
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      minimumSize: const Size(360, 60), // Define o tamanho mínimo dos botões
      padding: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

    return AlertDialog(
      backgroundColor: const Color(0xFF0088B7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 600,
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<int>(
                  future: _totalReviewsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final totalReviews = snapshot.data!;
                      return Center(
                        child: Text(
                          'Total de Participantes: $totalReviews',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xFF0088B7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    // Display a loading indicator while fetching data
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            const SizedBox(height: 35),
            FutureBuilder<Map<String, dynamic>>(
              future: _emailsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Map<String, dynamic> emailInfo = snapshot.data!;
                  final String email = emailInfo['server_email'] ??
                      ''; // Access the email from the map
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          'E-mail para envio: $email',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          final reviews = await _getReviews();
                          _submitForm([email], reviews,
                              emailInfo); // Pass email as a list to _submitForm
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Enviar Resultados',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF0088B7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                // Display a loading indicator while fetching data
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 20), // Adicionei um espaço extra aqui
          ],
        ),
      ),
    );
  }
}
