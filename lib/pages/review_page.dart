import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';
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
  late Future<int> _totalMonitorReportsFuture;
  late Future<Map<String, dynamic>> _emailsFuture;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _totalReviewsFuture = _getTotalReviews('reports');
    _totalMonitorReportsFuture = _getTotalReviews('monitor_reports');
    _emailsFuture = _getEmails();
  }

  Future<void> sendEmail(List<String> csvPaths, String recipient, String emailBody, String schoolName, String serverName) async {
    final smtpServer = gmail('danielyudicarvalho@gmail.com', 'rkww hvdl qrav fmel');

    final message = Message()
      ..from = Address('danielyudicarvalho@gmail.com', 'Yudi')
      ..recipients.add(recipient)
      ..subject = 'Resultado $schoolName - $serverName'
      ..text = emailBody
      ..attachments.addAll(csvPaths.map((path) => FileAttachment(File(path))));

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
    return await openDatabase(path, version: 1);
  }

  Future<int> _getTotalReviews(String tableName) async {
    final database = await _openDatabase();
    final count = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
    print('Count for $tableName: $count');
    return count ?? 0;
  }

  Future<Map<String, dynamic>> _getEmails() async {
    final Database database = await _openEmailsDatabase();
    final List<Map<String, dynamic>> maps = await database.query(
      'login_info',
      orderBy: 'id DESC',
      limit: 1,
    );
    return maps.isNotEmpty ? maps.first : {};
  }

  Future<Database> _openEmailsDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/app.db";
    return await openDatabase(path, version: 1);
  }

  Future<List<Map<String, dynamic>>> _getReviews(String tableName) async {
    final database = await _openDatabase();
    return await database.query(tableName);
  }

  Future<void> _submitForm(List<String> emails, List<Map<String, dynamic>> reviews, List<Map<String, dynamic>> monitorReports, Map<String, dynamic> loginInfo) async {
    final csvContentReviews = _generateCSV(reviews, loginInfo, 'reports');
    final csvContentMonitorReports = _generateCSV(monitorReports, loginInfo, 'monitor_reports');

    final emailBody = _generateEmailBody(loginInfo);

    final schoolName = loginInfo['school_name'];
    final serverName = loginInfo['server_name'];

    final csvPathReviews = await _saveCSV(csvContentReviews, 'reviews.csv');
    final csvPathMonitorReports = await _saveCSV(csvContentMonitorReports, 'monitor_reports.csv');

    for (var email in emails) {
      try {
        await sendEmail([csvPathReviews, csvPathMonitorReports], email, emailBody, schoolName, serverName);
      } catch (e) {
        print('Error sending email: $e');
      }
    }

    await _deleteReviews('reports');
    await _deleteReviews('monitor_reports');
  }

  String _generateEmailBody(Map<String, dynamic> loginInfo) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('School Name: ${loginInfo['school_name']}');
    buffer.writeln('Server Name: ${loginInfo['server_name']}');
    buffer.writeln('Study Count: ${loginInfo['student_count']}');
    return buffer.toString();
  }

  String _generateCSV(List<Map<String, dynamic>> data, Map<String, dynamic> loginInfo, String tableName) {
    final csvBuffer = StringBuffer();
    if (tableName == 'reports') {
      csvBuffer.write('Rating\n');
    } else {
      csvBuffer.write('Rating, - , - \n');
    }

    for (var row in data) {
      if (tableName == 'reports') {
        csvBuffer.write('${row['rating']}\n');
      } else {
        csvBuffer.write('${row['rating']},${row['options']},${row['feedback']}\n');
      }
    }

    return csvBuffer.toString();
  }

  Future<String> _saveCSV(String csvContent, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final File file = File(filePath);
    await file.writeAsString(csvContent);
    return filePath;
  }

  Future<void> _deleteReviews(String tableName) async {
    final database = await _openDatabase();
    await database.delete(tableName);
  }

  void openConfirmationPage() {
    showDialog(
        context: context,
        builder: (context) {
          return const ConfirmationPage();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      minimumSize: const Size(360, 60),
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
      content: SizedBox(
        width: 600,
        height: 275,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<int>(
                future: _totalReviewsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final totalReviews = snapshot.data!;
                    return Center(
                      child: Text('Total de Participantes: $totalReviews',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<int>(
                future: _totalMonitorReportsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final totalMonitorReports = snapshot.data!;
                    return Center(
                      child: Text('Total de Monitor Reports: $totalMonitorReports',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<Map<String, dynamic>>(
                future: _emailsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final Map<String, dynamic> emailInfo = snapshot.data!;
                    final String email = emailInfo['server_email'] ?? '';
                    return Column(
                      children: [
                        ListTile(
                          title: Text('E-mail para envio: $email',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: buttonStyle,
                          onPressed: () async {
                            final reviews = await _getReviews('reports');
                            final monitorReports = await _getReviews('monitor_reports');
                            _submitForm([email], reviews, monitorReports, emailInfo);
                            Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (Route<dynamic> route) => false);
                            openConfirmationPage();
                          },
                          child: const Text('SIM'),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OptionPage()));
                          },
                          child: const Text('NÃO'),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
