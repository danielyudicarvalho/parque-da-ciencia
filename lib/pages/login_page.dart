import 'package:flutter/material.dart';
import 'package:pc_app/pages/home_page.dart';
import 'package:pc_app/util/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Strings para armazenar nome e email
  String nome = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 30,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Spacer(),

            // Campo do Nome
            TextField(
              onChanged: (text){
                nome = text;
              },
              decoration: const InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15,),

            // Campo do Email
            TextField(
              onChanged: (text){
                email = text;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            MyButton(text: "Entrar", onPressed: () {
              // Recolher nome e email

              // Entrar na HomePage
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            }),

            const Spacer(flex: 1,)
          ],
        ),
      ),

    );
  }
}
