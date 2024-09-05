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
        if (option == 'Boa variedade mas falta manutenção') option1 = option;
        if (option == 'Interessante mas faltou interatividade e envolvimento') option2 = option;
        if (option == 'Muito Bom mas tem poucas atrações') option3 = option;
        if (option == 'Boas atrações mas achei um pouco confuso') option4 = option;
      } else {
        selectedOptions.remove(option);
        if (option == 'Boa variedade mas falta manutenção') option1 = '';
        if (option == 'Interessante mas faltou interatividade e envolvimento') option2 = '';
        if (option == 'Muito Bom mas tem poucas atrações') option3 = '';
        if (option == 'Boas atrações mas achei um pouco confuso') option4 = '';
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
                        'Boa variedade mas falta manutenção',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Boa variedade mas falta manutenção'),
                      onChanged: (value) {
                        handleCheckboxChange('Boa variedade mas falta manutenção', value);
                      },
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Interessante mas faltou interatividade e envolvimento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Interessante mas faltou interatividade e envolvimento'),
                      onChanged: (value) {
                        handleCheckboxChange('Interessante mas faltou interatividade e envolvimento', value);
                      },
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Muito Bom mas tem poucas atrações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Muito Bom mas tem poucas atrações'),
                      onChanged: (value) {
                        handleCheckboxChange('Muito Bom mas tem poucas atrações', value);
                      },
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Boas atrações mas achei um pouco confuso',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedOptions.contains('Boas atrações mas achei um pouco confuso'),
                      onChanged: (value) {
                        handleCheckboxChange('Boas atrações mas achei um pouco confuso', value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 65), // Increased spacing here
              // Feedback text field
              TextField(
                onChanged: (text) {
                  feedbackText = text;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // White border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white, // White border on focus
                    ),
                  ),
                  hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
                ),
                style: TextStyle(color: Colors.white), // White text
              ),
              const SizedBox(height: 30),
              // Cancel and save buttons
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
