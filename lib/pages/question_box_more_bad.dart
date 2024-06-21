import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxMoreBad extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;
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
      widget.onSave(option1, option2, option3, option4, feedbackText);
      Navigator.of(context).pop();
    }
  }

  void handleCheckboxChange(String option, bool? isChecked) {
    setState(() {
      if (isChecked != null && isChecked) {
        selectedOptions.add(option);
        if (option == 'Acho que o parque está um pouco desatualizado e mal conservado') option1 = option;
        if (option == 'Acho que a falta de mais funcionários prejudicou o parque') option2 = option;
        if (option == 'Acho que tem poucas atrações') option3 = option;
        if (option == 'A falta de estrutura do parque prejudicou a minhas experiência') option4 = option;
      } else {
        selectedOptions.remove(option);
        if (option == 'Acho que o parque está um pouco desatualizado e mal conservado') option1 = '';
        if (option == 'Acho que a falta de mais funcionários prejudicou o parque') option2 = '';
        if (option == 'Acho que tem poucas atrações') option3 = '';
        if (option == 'A falta de estrutura do parque prejudicou a minhas experiência') option4 = '';
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
          height: 500,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text(
                          'Acho que o parque está um pouco desatualizado e mal conservado',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        value: selectedOptions.contains('Acho que o parque está um pouco desatualizado e mal conservado'),
                        onChanged: (value) {
                          handleCheckboxChange('Acho que o parque está um pouco desatualizado e mal conservado', value);
                        },
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        title: const Text(
                          'Acho que a falta de mais funcionários prejudicou o parque',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        value: selectedOptions.contains('Acho que a falta de mais funcionários prejudicou o parque'),
                        onChanged: (value) {
                          handleCheckboxChange('Acho que a falta de mais funcionários prejudicou o parque', value);
                        },
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        title: const Text(
                          'Acho que tem poucas atrações',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        value: selectedOptions.contains('Acho que tem poucas atrações'),
                        onChanged: (value) {
                          handleCheckboxChange('Acho que tem poucas atrações', value);
                        },
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        title: const Text(
                          'A falta de estrutura do parque prejudicou a minhas experiência',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        value: selectedOptions.contains('A falta de estrutura do parque prejudicou a minhas experiência'),
                        onChanged: (value) {
                          handleCheckboxChange('A falta de estrutura do parque prejudicou a minhas experiência', value);
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
                    ],
                  ),
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
