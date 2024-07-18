import 'package:flutter/material.dart';
import '../util/my_button.dart'; // Adjust the import path as per your project structure
import 'confirmation_page.dart'; // Adjust the import path as per your project structure

class QuestionBoxBad extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;
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
    if (selectedOptions.isNotEmpty) {
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
        if (option == 'Acho que o parque está um pouco desatualizado e mal conservado') option1 = option;
        if (option == 'Acho que a falta de mais funcionários prejudicou o parque') option2 = option;
        if (option == 'Acho que tem poucas atrações') option3 = option;
        if (option == 'A falta de estrutura do parque prejudicou a minha experiência') option4 = option;
      } else {
        selectedOptions.remove(option);
        if (option == 'Acho que o parque está um pouco desatualizado e mal conservado') option1 = '';
        if (option == 'Acho que a falta de mais funcionários prejudicou o parque') option2 = '';
        if (option == 'Acho que tem poucas atrações') option3 = '';
        if (option == 'A falta de estrutura do parque prejudicou a minha experiência') option4 = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF0088B7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      titlePadding: EdgeInsets.zero,
      title: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "Por que você escolheu essa opção?",
            style: TextStyle(
              color: Color(0xFF0088B7),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),

      content: SingleChildScrollView(
        child: SizedBox(
          width: 800,
          height: 500,

          child: Column(
            children: [
              Theme(
                data: ThemeData(
                  checkboxTheme: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    checkColor: WidgetStateProperty.all(
                      const Color(0xFF0088B7),
                    ),
                    fillColor: WidgetStateProperty.resolveWith(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text(
                        'Acho que o parque está um pouco desatualizado e mal conservado',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      value: selectedOptions.contains('Acho que tem poucas atrações'),
                      onChanged: (value) {
                        handleCheckboxChange('Acho que tem poucas atrações', value);
                      },
                    ),

                    const SizedBox(height: 10),

                    CheckboxListTile(
                      title: const Text(
                        'A falta de estrutura do parque prejudicou a minha experiência',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      value: selectedOptions.contains('A falta de estrutura do parque prejudicou a minha experiência'),
                      onChanged: (value) {
                        handleCheckboxChange('A falta de estrutura do parque prejudicou a minha experiência', value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Campo de explicação
              const SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  feedbackText = text;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Borda branca
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white, // Borda branca ao focar
                    ),
                  ),
                  hintText:
                  "Explique a sua escolha para nos ajudar a melhorar...",
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
                ),
                style: TextStyle(color: Colors.white), // Texto branco
              ),

              const SizedBox(height: 30),

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
