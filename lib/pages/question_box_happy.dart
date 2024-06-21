import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxHappy extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;
  final VoidCallback onCancel;

  const QuestionBoxHappy({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<QuestionBoxHappy> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxHappy> {
  List<String> selectedOptions = [];
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';
  String feedbackText = '';

  bool isSaveButtonEnabled() {
    return selectedOptions.isNotEmpty;
  }

  void handleSavePressed() {
    if (isSaveButtonEnabled()) {
      widget.onSave(
        option1,
        option2,
        option3,
        option4,
        feedbackText,
      );
      Navigator.of(context).pop();
    }
  }

  void handleCheckboxChange(String option, bool? isChecked) {
    setState(() {
      if (isChecked != null && isChecked) {
        selectedOptions.add(option);
        if (option == 'Variedade de atrações') option1 = option;
        if (option == 'Bom atendimento') option2 = option;
        if (option == 'Boa estrutura') option3 = option;
        if (option == 'Aprendizagem interessante') option4 = option;
      } else {
        selectedOptions.remove(option);
        if (option == 'Variedade de atrações') option1 = '';
        if (option == 'Bom atendimento') option2 = '';
        if (option == 'Boa estrutura') option3 = '';
        if (option == 'Aprendizagem interessante') option4 = '';
      }
    });
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
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 800,
          height: 450,
          child: Column(
            children: [
              CheckboxListTile(
                title: const Text(
                  'Variedade de atrações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Variedade de atrações'),
                onChanged: (value) {
                  handleCheckboxChange('Variedade de atrações', value);
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  'Bom atendimento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Bom atendimento'),
                onChanged: (value) {
                  handleCheckboxChange('Bom atendimento', value);
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  'Boa estrutura',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Boa estrutura'),
                onChanged: (value) {
                  handleCheckboxChange('Boa estrutura', value);
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  'Aprendizagem interessante',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Aprendizagem interessante'),
                onChanged: (value) {
                  handleCheckboxChange('Aprendizagem interessante', value);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  feedbackText = text;
                },
                style: const TextStyle(color: Colors.white, fontSize: 25),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                  hintStyle: const TextStyle(color: Colors.white70, fontSize: 25),
                ),
              ),
              const SizedBox(height: 20),
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
                    onPressed: isSaveButtonEnabled() ? handleSavePressed : () {},
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
