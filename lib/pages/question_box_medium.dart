import 'package:flutter/material.dart';
import '../util/my_button.dart';
import 'confirmation_page.dart';

class QuestionBoxMedium extends StatefulWidget {
  final Function(String, String) onSave;
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
              CheckboxListTile(
                title: const Text(
                  'Boa variedade, porém falta manutenção',
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                value: selectedOptions.contains('Opção 1'),
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
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Interessante, mas faltou interatividade e envolvimento',
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
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Muito Bom, porém tem poucas atrações',
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
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Boas atrações, mas achei um pouco confuso',
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
              const SizedBox(height: 20),
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
