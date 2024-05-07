import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxBad extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxBad({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<QuestionBoxBad> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxBad> {
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
      backgroundColor: const Color(0xFF0088B7),
      title: const Text(
        "Por que você escolheu essa opção?",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
      ),

      content: SingleChildScrollView(
        child: SizedBox(
          width: 800,
          height: 500,

          child: Column(
            children: [
              CheckboxListTile(
                title: const Text(
                  'Acho que o parque está um pouco desatualizado e mal conservado',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold
                  ),
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

              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text(
                  'Acho que a falta de mais funcionários prejudicou o parque',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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

              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text(
                  'Acho que tem poucas atrações',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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

              const SizedBox(height: 10),

              CheckboxListTile(
                title: const Text(
                  'A falta de estrutura do parque prejudicou a minhas experiência',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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

              const SizedBox(height: 10),

              // Campo de explicaçao
              const TextField(
                //controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
                  )
              ),

              const SizedBox(height: 20),

              // Botoes cancelar e salvar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    text: "Cancelar",
                    onPressed: widget.onCancel,
                  ),

                  const SizedBox(width: 75),

                  MyButton(
                    text: "Salvar",
                    onPressed: handleSavePressed,
                  ),

                  const SizedBox(width: 130),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
