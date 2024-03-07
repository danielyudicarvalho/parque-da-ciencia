import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBox extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBox({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<QuestionBox> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBox> {
  String selectedOption = '';

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
        height: 500,

        child: Column(
          children: [
            RadioListTile<String>(
              title: Text('Gostei!', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: Text('Nao tenho opiniao..', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: Text('Meio confuso...', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 3',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: Text('Estou insatisfeito!', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 4',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),
            Spacer(),
            const TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
              )
            ),
            Spacer(flex: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                MyButton(text: "Cancelar", onPressed: widget.onCancel),
                const SizedBox(width: 75,),
                MyButton(text: "Salvar", onPressed: widget.onSave,),
                Spacer()
              ]
            ),
            Spacer(flex: 1,)
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent[400],
    );
  }
}
