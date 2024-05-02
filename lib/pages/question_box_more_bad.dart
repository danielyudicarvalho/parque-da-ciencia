import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxMoreBad extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxMoreBad({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<QuestionBoxMoreBad> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxMoreBad> {
  List<String> selectedOptions = []; // List to store chosen options

  bool isSaveButtonEnabled() {
    return selectedOptions.isNotEmpty;
  }

  void handleSavePressed() {
    if (selectedOptions.isNotEmpty) { // Corrected from selectedOption to selectedOptions
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
            CheckboxListTile(
              title: const Text(
                'Acho que o parque está um pouco desatualizado e mal conservado',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              value: selectedOptions.contains('Opção 1'), // Check if the option is selected
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add('Opção 1');
                  } else {
                    selectedOptions.remove('Opção 1');
                  }
                });
              },
            ),

            CheckboxListTile(
              title: const Text(
                'Acho que a falta de mais funcionários prejudicou o parque',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              value: selectedOptions.contains('Opção 2'),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add('Opção 2');
                  } else {
                    selectedOptions.remove('Opção 2');
                  }
                });
              },
            ),

            CheckboxListTile(
              title: const Text(
                'Acho que tem poucas atrações',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              value: selectedOptions.contains('Opção 3'),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add('Opção 3');
                  } else {
                    selectedOptions.remove('Opção 3');
                  }
                });
              },
            ),

            CheckboxListTile(
              title: const Text(
                'A falta de estrutura do parque prejudicou a minhas experiência',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              value: selectedOptions.contains('Opção 4'),
              onChanged: (value) {
                setState(() {
                  if (value != null && value) {
                    selectedOptions.add('Opção 4');
                  } else {
                    selectedOptions.remove('Opção 4');
                  }
                });
              },
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
                const SizedBox(width: 75),
                MyButton(
                  text: "Salvar",
                  onPressed: handleSavePressed,
                ),
                const Spacer()
              ],
            ),
            const Spacer(flex: 1)
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent[400],
    );
  }
}
