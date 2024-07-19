import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_app/pages/error_page.dart';
import 'package:pc_app/pages/home_page.dart';
import 'package:pc_app/pages/review_page.dart';
import 'package:pc_app/pages/simple_nps_page.dart';
import 'package:sqflite/sqflite.dart';

import 'confirmation_page.dart'; // Import SimpleNpsPage

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  void initState() {
    super.initState();
  }

  void openReviewPage() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    // Verificando conexão com a internet
    if(connectivityResult.contains(ConnectivityResult.none)) {
      showDialog(
          context: context,
          builder: (context) {
            return const ErrorPage(image: 'lib/images/no-wifi.png', frase: 'Sem conexão com a internet!');
          }
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const ReviewPage();
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definindo um tamanho padrão para todos os botões
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0088B7),
      minimumSize: const Size(520, 80), // Define o tamanho mínimo dos botões
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0088B7),
        centerTitle: true,
        title: const Text(
          "Iniciando passeio",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Define a cor da seta de volta para branco
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8, bottom: 4),
            child: Image.asset(
              'lib/images/logo_vem_p_ufms.png',
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 8, bottom: 4),
            child: Image.asset('lib/images/logo_ufms.png'),
          )
        ],
      ),

      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("lib/images/logo_parque.png",
                    width: 280, height: 280),

                const Spacer(),

                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SimpleNpsPage()),
                    );
                  },
                  child: const Text(
                    'Opinião do Aluno',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                ),

                const Spacer(),

                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text(
                    'Opinião do Responsável pela Escola',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              ElevatedButton(
                  style: buttonStyle,
                  onPressed: () => openReviewPage(),
                  child: const Text(
                    'Enviar Opiniões',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                ),

                const Spacer(flex: 2,),
              ],
            ),
          ),
        ),
    );
  }
}
