import 'package:flutter/material.dart';
import 'package:pc_app/pages/simple_nps_page.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,

      content: SizedBox(
        width: 800,
        height: 400,

        child: Column(
          children: [
            Image.asset(
              "lib/images/logo_parque_transp.png",
              width: 350, // ajuste o tamanho da imagem conforme necessário
              height: 350,
            ),

            const SizedBox(),

            const Text(
              "Obrigado pelo seu feedback!",
              style: TextStyle(
                color: Color(0xFF0088B7),
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(),
          ]
        )
      ),
    );
  }
}
