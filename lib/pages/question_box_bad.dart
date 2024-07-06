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
  State<QuestionBoxBad> createState() => _QuestionBoxBadState();
}

class _QuestionBoxBadState extends State<QuestionBoxBad> {
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
        feedbackText,);
      Navigator.of(context).pop();
    }
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
                        'Acho que o parque está um pouco desatualizado e mal conservado',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      value: selectedOptions.contains('Acho que o parque está um pouco desatualizado e mal conservado'),
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value) {
                            selectedOptions.add('Acho que o parque está um pouco desatualizado e mal conservado');
                          } else {
                            selectedOptions.remove('Acho que o parque está um pouco desatualizado e mal conservado');
                          }
                        });
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
                        setState(() {
                          if (value != null && value) {
                            selectedOptions.add('Acho que a falta de mais funcionários prejudicou o parque');
                          } else {
                            selectedOptions.remove('Acho que a falta de mais funcionários prejudicou o parque');
                          }
                        });
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
                        setState(() {
                          if (value != null && value) {
                            selectedOptions.add('Acho que tem poucas atrações');
                          } else {
                            selectedOptions.remove('Acho que tem poucas atrações');
                          }
                        });
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
                        setState(() {
                          if (value != null && value) {
                            selectedOptions.add('A falta de estrutura do parque prejudicou a minha experiência');
                          } else {
                            selectedOptions.remove('A falta de estrutura do parque prejudicou a minha experiência');
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                onChanged: (text) {
                  feedbackText = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
                ),
              ),

              const SizedBox(height: 30),
              // Botões cancelar e salvar
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
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
