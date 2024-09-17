import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../util/my_button.dart';
import 'generic_pop_up.dart';
import 'login_page.dart';

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
    _totalReviewsFuture = _getTotalCount('reports');
    _totalMonitorReportsFuture = _getTotalCount('monitor_reports');
    _emailsFuture = _getEmails();
  }

  Future<void> sendEmail(List<String> csvPaths, String recipient, String emailBody, String schoolName, String serverName) async {
    final smtpServer = gmail('dipc.proece@ufms.br', 'vpov fewv ytse rzqg');

    try {
      for (var path in csvPaths) {
        if (!await File(path).exists()) {
          print('File does not exist at path: $path');
          throw 'File does not exist at path: $path';
        }
      }

      // Validate recipient, email body, and attachments
      if (recipient.isEmpty || emailBody.isEmpty || csvPaths.isEmpty) {
        throw 'Invalid email parameters: recipient, body, or attachments are missing.';
      }

      final message = Message()
        ..from = Address('dipc.proece@ufms.br', 'PC-App')
        ..recipients.add(recipient)
        ..subject = 'Resultado $schoolName - $serverName'
        ..text = emailBody
        ..attachments.addAll(csvPaths.map((path) {
          print('Attaching file: $path');
          return FileAttachment(File(path));
        }));

      print('Sending email to: $recipient with subject: Resultado $schoolName - $serverName');
      await send(message, smtpServer);
      print('Email sent successfully.');
    } catch (e) {
      print('Error sending email: $e');
    }
  }


  Future<Database> _openDatabase(String dbName) async {
    final path = (await getApplicationDocumentsDirectory()).path + "/$dbName.db";
    return await openDatabase(path, version: 1);
  }

  Future<int> _getTotalCount(String tableName) async {
    final database = await _openDatabase("reports");
    return Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM $tableName')) ?? 0;
  }

  Future<Map<String, dynamic>> _getEmails() async {
    final database = await _openDatabase("app");
    final List<Map<String, dynamic>> maps = await database.query(
      'login_info',
      orderBy: 'id DESC',
      limit: 1,
    );

    if (maps.isEmpty) {
      print('No emails found in the database.');
      return {};
    } else {
      print('Retrieved email information: ${maps.first}');
      return maps.first;
    }
  }


  Future<List<Map<String, dynamic>>> _getData(String tableName) async {
    final database = await _openDatabase("reports");
    return await database.query(tableName);
  }
 // Add this import for email validation

  Future<void> _submitForm(List<String> emails, List<Map<String, dynamic>> reviews, List<Map<String, dynamic>> monitorReports, Map<String, dynamic> loginInfo) async {
    if (reviews.isEmpty && monitorReports.isEmpty) {
      _showErrorMessage();
      return;
    }

    final csvPaths = await Future.wait([
      _saveCSV(_generateCSV(reviews, loginInfo), 'aval_alunos_${loginInfo['school_name']}.csv'),
      _saveCSV(_generateCSV(monitorReports, loginInfo), 'aval_responsaveis_${loginInfo['school_name']}.csv'),
    ]);

    final emailBody = _generateEmailBody(loginInfo);

    for (var email in emails) {
      if (email.isNotEmpty && EmailValidator.validate(email)) {
        try {
          print('Attempting to send email to: $email');
          await sendEmail(csvPaths, email, emailBody, loginInfo['school_name'], loginInfo['server_name']);
        } catch (e) {
          print('Error sending email to $email: $e');
        }
      } else {
        print('Invalid email address: $email. Skipping...');
      }
    }

    await _clearTable('reports');
    await _clearTable('monitor_reports');
  }


  String _generateEmailBody(Map<String, dynamic> loginInfo) {
    final dateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final emailBody = '''
  Nome da escola: ${loginInfo['school_name']}
  Servidor responsável: ${loginInfo['server_name']}
  Número de alunos durante a visita: ${loginInfo['student_count']}
  Idade Mínima: ${loginInfo['min_age']}
  Idade Máxima: ${loginInfo['max_age']}
  Cidade: ${loginInfo['city_district']}
  Data e Hora: $dateTime
  ''';

    print('Generated Email Body: $emailBody');
    return emailBody;
  }


  // Helper method to get formatted date and time
  String getFormattedDateTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(now);
  }


// Generate CSV with the updated structure
  String _generateCSV(List<Map<String, dynamic>> data, Map<String, dynamic> loginInfo) {
    final csvBuffer = StringBuffer();

    // Write the header with additional fields
    csvBuffer.writeln(
        'School_Name, Server_Responsible, Student_Count, Visit_DateTime, '
            'Rating, Feedback, Option_1, Option_2, Option_3, Option_4, '
            'Min_Age, Max_Age, City_District'
    );

    // Write the rows with additional fields
    for (var row in data) {
      csvBuffer.writeln(
          '${loginInfo['school_name']},'
              '${loginInfo['server_name']},'
              '${loginInfo['student_count']},'
              '${getFormattedDateTime()},'
              '${row['rating']},'
              '${row['feedback']},'
              '${row['option1']},'
              '${row['option2']},'
              '${row['option3']},'
              '${row['option4']},'
              '${loginInfo['min_age']},'
              '${loginInfo['max_age']},'
              '${loginInfo['city_district']}'
      );
    }

    return csvBuffer.toString();
  }

  String _generateServerCSV(List<Map<String, dynamic>> data, Map<String, dynamic> loginInfo) {
    final csvBuffer = StringBuffer();

    // Write the header with additional fields
    csvBuffer.writeln(
        'School_Name, Server_Responsible, Student_Count, Visit_DateTime, '
            'Server_Rating, Feedback, Option_1, Option_2, Option_3, Option_4, '
            'Min_Age, Max_Age, City_District'
    );

    // Write the rows with additional fields
    for (var row in data) {
      csvBuffer.writeln(
          '${loginInfo['school_name']},'
              '${loginInfo['server_name']},'
              '${loginInfo['student_count']},'
              '${getFormattedDateTime()},'
              '${row['rating']},'
              '${row['feedback']},'
              '${row['option1']},'
              '${row['option2']},'
              '${row['option3']},'
              '${row['option4']},'
              '${loginInfo['min_age']},'
              '${loginInfo['max_age']},'
              '${loginInfo['city_district']}'
      );
    }

    return csvBuffer.toString();
  }


  Future<String> _saveCSV(String csvContent, String fileName) async {
    final filePath = '${(await getApplicationDocumentsDirectory()).path}/$fileName';
    final file = File(filePath);

    // Debugging the CSV content and file path
    print('Saving CSV to path: $filePath');
    print('CSV Content: $csvContent');

    await file.writeAsString(csvContent);
    print('CSV saved successfully at: $filePath');

    return filePath;
  }


  Future<void> _clearTable(String tableName) async {
    final database = await _openDatabase("reports");
    await database.delete(tableName);
    print('Cleared table: $tableName');
  }


  void _showErrorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const GenericPopUp(image: 'lib/images/warning.png', frase: 'Nenhuma avaliação!');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      minimumSize: const Size(360, 60),
      padding: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );

    return AlertDialog(
      backgroundColor: const Color(0xFF0088B7),
      content: SizedBox(
        width: 800,
        height: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              FutureBuilder<int>(
                future: _totalReviewsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(
                      child: Text(
                        'Total de Avaliações de Alunos: ${snapshot.data}',
                        style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              FutureBuilder<int>(
                future: _totalMonitorReportsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(
                      child: Text(
                        'Total de Avaliações de Responsáveis pela Escola: ${snapshot.data}',
                        style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 35),

              ElevatedButton(
                style: buttonStyle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.email_rounded, color: Colors.black, size: 50),
                    SizedBox(width: 10),
                    Text('Enviar Avaliações', style: TextStyle(fontSize: 24, color: Colors.black)),
                  ],
                ),
                onPressed: () async {
                  final reviews = await _getData('reports');
                  final monitorReports = await _getData('monitor_reports');
                  final emails = await _getEmails();

                  if (reviews.isEmpty && monitorReports.isEmpty) {
                    _showErrorMessage();
                    return;
                  }

                  await _submitForm(emails.values.map((e) => e.toString()).toList(), reviews, monitorReports, emails);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (
                          context) => const LoginPage()), (
                      Route<dynamic> route) => false
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const GenericPopUp(image: 'lib/images/mail_sent.png', frase: 'Email enviado!');
                      }
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.black, size: 50),
                    SizedBox(width: 10),
                    Text('Voltar para o Início', style: TextStyle(fontSize: 24, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}