import 'dart:convert'; // Import to use jsonDecode
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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
    final smtpServer = gmail('sepoc.proece@ufms.br', 'jsyb cqnf ybtr wztm');

    try {
      for (var path in csvPaths) {
        if (!await File(path).exists()) {
          print('File does not exist at path: $path');
          throw 'File does not exist at path: $path';
        }
      }

      if (recipient.isEmpty || emailBody.isEmpty || csvPaths.isEmpty) {
        throw 'Invalid email parameters: recipient, body, or attachments are missing.';
      }

      final message = Message()
        ..from = Address('sepoc.proece@ufms.br', 'PC-App')
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
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + "/$dbName.db";

    return openDatabase(
      path,
      version: 1,
      onOpen: (db) {
        print('Database opened at $path');
      },
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE login_info (
            id INTEGER PRIMARY KEY,
            server_name TEXT,
            server_email TEXT,
            student_count TEXT,
            school_name TEXT,
            age_ranges TEXT,
            city TEXT,
            district TEXT
          )
        ''');
      },
    );
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
      Map<String, dynamic> loginInfo = Map<String, dynamic>.from(maps.first);

      if (loginInfo.containsKey('age_ranges')) {
        loginInfo['age_ranges'] = jsonDecode(loginInfo['age_ranges']);
      }
      return loginInfo;
    }
  }

  Future<List<Map<String, dynamic>>> _getData(String tableName) async {
    final database = await _openDatabase("reports");
    return await database.query(tableName);
  }

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
    final ageRanges = (loginInfo['age_ranges'] as List<dynamic>).join(", ");
    final emailBody = '''
  Nome da escola: ${loginInfo['school_name']}
  Servidor responsável: ${loginInfo['server_name']}
  Número de alunos durante a visita: ${loginInfo['student_count']}
  Faixa etária selecionada: $ageRanges
  Cidade: ${loginInfo['city']}
  Bairro: ${loginInfo['district']}
  Data e Hora: $dateTime
  ''';

    print('Generated Email Body: $emailBody');
    return emailBody;
  }
      


  String _generateCSV(List<Map<String, dynamic>> data, Map<String, dynamic> loginInfo) {
  final csvBuffer = StringBuffer();

  // Write the header including each age range as a separate column
  csvBuffer.write('School_Name,Server_Responsible,Student_Count,Visit_DateTime,Rating,Feedback,Option_1,Option_2,Option_3,Option_4,');
  final ageRanges = loginInfo['age_ranges'] as List<dynamic>;
  // Adding age range columns
  for (var ageRange in ageRanges) {
    csvBuffer.write('$ageRange,');
  }
  csvBuffer.writeln('City,District');

  // Write the rows including the boolean values for each age range
  for (var row in data) {
    csvBuffer.write(
        '${loginInfo['school_name']},'
        '${loginInfo['server_name']},'
        '${loginInfo['student_count']},'
        '${getFormattedDateTime()},'
        '${row['rating'] ?? ''},'
        '${row['feedback'] ?? ''},'
        '${row['option1'] ?? ''},'
        '${row['option2'] ?? ''},'
        '${row['option3'] ?? ''},'
        '${row['option4'] ?? ''},'
    );

    // Adding the age range columns
    List<String> selectedAgeRanges = List<String>.from(loginInfo['age_ranges']);
    for (var ageRange in ageRanges) {
      csvBuffer.write('${selectedAgeRanges.contains(ageRange) ? 'true' : 'false'},');
    }

    csvBuffer.writeln('${loginInfo['city']},${loginInfo['district']}');
  }

  return csvBuffer.toString();
}


  Future<String> _saveCSV(String csvContent, String fileName) async {
    final filePath = '${(await getApplicationDocumentsDirectory()).path}/$fileName';
    final file = File(filePath);

    print('Saving CSV to path: $filePath');
    print('CSV Content: $csvContent');

    await file.writeAsString(csvContent);
    print('CSV saved successfully at: $filePath');

    return filePath;
  }

  Future<void> _clearTable(String tableName) async {
    final database = await _openDatabase("reports");
    try {
      await database.delete(tableName);
      print('Cleared table: $tableName');
    } catch (e) {
      print('Error clearing table: $e');
    }
  }

  void _showErrorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const GenericPopUp(image: 'lib/images/warning.png', frase: 'Nenhuma avaliação!');
      }
    );
  }

  String getFormattedDateTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(now);
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

              FutureBuilder<Map<String, dynamic>>(
                future: _emailsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(
                      child: Text(
                        '(CONFIRMAR) Email: ${snapshot.data?['server_email']}',
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
                  showDialog(
                    context: context,
                    barrierDismissible: false, // Impede o usuário de fechar manualmente
                    builder: (context) {
                      return const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Enviando emails..."),
                          ],
                        ),
                      );
                    },
                  );

                  try {
                    final reviews = await _getData('reports');
                    final monitorReports = await _getData('monitor_reports');
                    final emails = await _getEmails();

                    // Fechar o loading antes de mostrar erro
                    if (reviews.isEmpty && monitorReports.isEmpty) {
                      Navigator.of(context).pop(); // Fecha o loading
                      _showErrorMessage(); // Mostra pop-up de erro
                      return;
                    }

                    await _submitForm(emails.values.map((e) => e.toString()).toList(), reviews, monitorReports, emails);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const GenericPopUp(image: 'lib/images/mail_sent.png', frase: 'Email enviado!');
                      }
                    );

                    // Espera um curto tempo para o usuário ver o sucesso antes de sair
                    await Future.delayed(Duration(seconds: 2));

                    // Navega para a tela de login
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                          (Route<dynamic> route) => false,
                    );
                  } catch (error) {
                    // Fechar o loading em caso de erro
                    Navigator.of(context).pop();

                    // Exibir pop-up de erro
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Erro"),
                          content: Text("Falha ao enviar os emails. Tente novamente."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Fechar o pop-up de erro
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
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
