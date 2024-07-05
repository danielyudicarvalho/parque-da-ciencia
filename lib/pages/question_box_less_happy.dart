import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxLessHappy extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;
  final VoidCallback onCancel;

  const QuestionBoxLessHappy({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<QuestionBoxLessHappy> createState() => _QuestionBoxLessHappyState();
}

class _QuestionBoxLessHappyState extends State<QuestionBoxLessHappy> {
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
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    checkColor: MaterialStateProperty.all(
                      const Color(0xFF0088B7),
                    ),
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
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
                        'Variedade de atrações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Variedade de atrações'),
                      onChanged: (value) {
                        handleCheckboxChange('Variedade de atrações', value);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Bom atendimento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Bom atendimento'),
                      onChanged: (value) {
                        handleCheckboxChange('Bom atendimento', value);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Boa estrutura',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Boa estrutura'),
                      onChanged: (value) {
                        handleCheckboxChange('Boa estrutura', value);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Aprendizagem interessante',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value:
                          selectedOptions.contains('Aprendizagem interessante'),
                      onChanged: (value) {
                        handleCheckboxChange(
                            'Aprendizagem interessante', value);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                onChanged: (text) {
                  feedbackText = text;
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Borda branca
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Borda branca ao focar
                  ),
                  hintText:
                      "Explique a sua escolha para nos ajudar a melhorar...",
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
                ),
                style: const TextStyle(color: Colors.white), // Texto branco
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
                    onPressed: isSaveButtonEnabled() ? handleSavePressed : null,
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
