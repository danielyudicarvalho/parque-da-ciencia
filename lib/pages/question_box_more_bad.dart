import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxMoreBad extends StatefulWidget {
  final Function(String, String) onSave;
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
  String feedbackText = '';

  bool isSaveButtonEnabled() {
    return selectedOptions.isNotEmpty;
  }

  void handleSavePressed() {
    if (selectedOptions.isNotEmpty) {
      widget.onSave(selectedOptions.join(', '), feedbackText);
      Navigator.of(context).pop();
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
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
                          'A falta de estrutura do parque prejudicou a minhas experiência',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        value: selectedOptions.contains('A falta de estrutura do parque prejudicou a minhas experiência'),
                        onChanged: (value) {
                          setState(() {
                            if (value != null && value) {
                              selectedOptions.add('A falta de estrutura do parque prejudicou a minhas experiência');
                            } else {
                              selectedOptions.remove('A falta de estrutura do parque prejudicou a minhas experiência');
                            }
                          });
                        },
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
