import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({super.key});

  final String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Por que você escolheu essa opção?",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),

      content: Container(
        width: 800,
        height: 700,

        child: Column(
          children: [
            RadioListTile<String>(
              title: Text('Opção 1', style: TextStyle(color: Colors.white),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {},
            ),

            RadioListTile<String>(
              title: Text('Opção 2', style: TextStyle(color: Colors.white),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {},
            ),

            RadioListTile<String>(
              title: Text('Opção 3', style: TextStyle(color: Colors.white),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {},
            ),

            RadioListTile<String>(
              title: Text('Opção 4', style: TextStyle(color: Colors.white),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {},
            ),
            Spacer(),
            const TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                hintStyle: TextStyle(color: Colors.white70),
              )
            ),
            Spacer(flex: 4,),
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent[400],
    );
  }
}
