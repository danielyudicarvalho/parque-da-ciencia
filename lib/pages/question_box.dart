import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBox extends StatefulWidget {
  final void Function(String reason, String review) onSave;
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
  String review = '';

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
              title: const Text('Gostei!', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Nao tenho opiniao..', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Meio confuso...', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 3',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Estou insatisfeito!', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 4',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                });
              },
            ),
            const Spacer(),

            // Campo de explicaçao
            TextField(
              onChanged: (text){
                review = text;
              },
              //controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
              )
            ),
            const Spacer(flex: 2,),

            // Botoes cancelar e salvar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                MyButton(text: "Cancelar", onPressed: widget.onCancel),
                const SizedBox(width: 75,),
                MyButton(text: "Salvar", onPressed: () {
                    widget.onSave(selectedOption, review);
                  },
                ),
                const Spacer()
              ]
            ),
            const Spacer(flex: 1,)
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent[400],
    );
  }
}
