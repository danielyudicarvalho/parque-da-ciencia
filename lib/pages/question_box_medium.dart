import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxMedium extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;
  final VoidCallback onCancel;

  const QuestionBoxMedium({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<QuestionBoxMedium> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxMedium> {
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
        if (option == 'Boa variedade, porém falta manutenção') option1 = option;
        if (option == 'Interessante, mas faltou interatividade e envolvimento') option2 = option;
        if (option == 'Muito Bom, porém tem poucas atrações') option3 = option;
        if (option == 'Boas atrações, mas achei um pouco confuso') option4 = option;
      } else {
        selectedOptions.remove(option);
        if (option == 'Boa variedade, porém falta manutenção') option1 = '';
        if (option == 'Interessante, mas faltou interatividade e envolvimento') option2 = '';
        if (option == 'Muito Bom, porém tem poucas atrações') option3 = '';
        if (option == 'Boas atrações, mas achei um pouco confuso') option4 = '';
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
              CheckboxListTile(
                title: const Text(
                  'Boa variedade, porém falta manutenção',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Boa variedade, porém falta manutenção'),
                onChanged: (value) {
                  handleCheckboxChange('Boa variedade, porém falta manutenção', value);
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Interessante, mas faltou interatividade e envolvimento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Interessante, mas faltou interatividade e envolvimento'),
                onChanged: (value) {
                  handleCheckboxChange('Interessante, mas faltou interatividade e envolvimento', value);
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Muito Bom, porém tem poucas atrações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Muito Bom, porém tem poucas atrações'),
                onChanged: (value) {
                  handleCheckboxChange('Muito Bom, porém tem poucas atrações', value);
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Boas atrações, mas achei um pouco confuso',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedOptions.contains('Boas atrações, mas achei um pouco confuso'),
                onChanged: (value) {
                  handleCheckboxChange('Boas atrações, mas achei um pouco confuso', value);
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 30),
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
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
