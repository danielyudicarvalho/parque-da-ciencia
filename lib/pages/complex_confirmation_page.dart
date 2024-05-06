import 'package:flutter/material.dart';
import 'package:pc_app/pages/home_page.dart';
import 'package:pc_app/pages/review_page.dart';
import 'package:pc_app/pages/simple_nps_page.dart';
import 'package:pc_app/pages/options_page.dart';


class ComplexConfirmationPage extends StatefulWidget {
  const ComplexConfirmationPage({Key? key}) : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ComplexConfirmationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OptionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback submetido'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Obrigado pelo seu feedback!',
              style: TextStyle(fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const Text(
              'Redirecionando em 5 segundos...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
