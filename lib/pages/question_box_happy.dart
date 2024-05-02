import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxHappy extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxHappy({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<QuestionBoxHappy> createState() => _QuestionBoxState();
}


class _QuestionBoxState extends State<QuestionBoxHappy> {
  String selectedOption = '';


  void handleSavePressed() {
    if (selectedOption.isNotEmpty) {
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Por que você escolheu essa opção?",
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
              title: const Text(
                  'Variedade de atrações',
                  style: TextStyle(color: Colors.white,
                      fontSize: 25)),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) => setState(() => selectedOption = value!),
            ),

            RadioListTile<String>(
              title: const Text('Bom atendimento', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 2',
              groupValue: selectedOption,
              onChanged: (value) => setState(() => selectedOption = value!),
            ),

            RadioListTile<String>(
              title: const Text('Boa estrutura', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 3',
              groupValue: selectedOption,
              onChanged: (value) => setState(() => selectedOption = value!),
            ),

            RadioListTile<String>(
              title: const Text('Aprendizagem interessante', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 4',
              groupValue: selectedOption,
              onChanged: (value) => setState(() => selectedOption = value!),
            ),

            const Spacer(),

            // Campo de explicaçao
            const TextField(
              //controller: controller,
                decoration: InputDecoration(
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
                  Spacer(),
                  MyButton(
                    text: "Cancelar",
                    onPressed: widget.onCancel,
                  ),
                  const SizedBox(width: 75,),
                  MyButton(
                    text: "Salvar",
                    onPressed: handleSavePressed,
                    // Disable button if no option is selected
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
