import 'package:flutter/material.dart';
import '../util/my_button.dart';
import 'confirmation_page.dart';

class QuestionBoxHappy extends StatefulWidget {
  final Function(String, String) onSave;
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
          height: 450,
          child: Column(
            children: [
              CheckboxListTile(
                title: const Text(
                  'Variedade de atrações',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                value: selectedOptions.contains('Variedade de atrações'),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedOptions.add('Variedade de atrações');
                    } else {
                      selectedOptions.remove('Variedade de atrações');
                    }
                  });
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  'Bom atendimento',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                value: selectedOptions.contains('Bom atendimento'),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedOptions.add('Bom atendimento');
                    } else {
                      selectedOptions.remove('Bom atendimento');
                    }
                  });
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  'Boa estrutura',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                value: selectedOptions.contains('Boa estrutura'),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedOptions.add('Boa estrutura');
                    } else {
                      selectedOptions.remove('Boa estrutura');
                    }
                  });
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text(
                  'Aprendizagem interessante',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                value: selectedOptions.contains('Aprendizagem interessante'),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedOptions.add('Aprendizagem interessante');
                    } else {
                      selectedOptions.remove('Aprendizagem interessante');
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
                  const SizedBox(width: 130,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
