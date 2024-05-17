import 'dart:ffi';

import 'package:flutter/material.dart';
import '../util/my_button.dart';
import 'confirmation_page.dart';

class QuestionBoxMedium extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxMedium({
    Key? key,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<QuestionBoxMedium> createState() => _QuestionBoxMediumState();
}

class _QuestionBoxMediumState extends State<QuestionBoxMedium> {
  List<String> selectedOptions = []; // List to store chosen options

  bool isSaveButtonEnabled() {
    return selectedOptions.isNotEmpty;
  }

  void handleSavePressed() {
    if (isSaveButtonEnabled()) {
      widget.onSave();
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
                        'Boa variedade, porém falta manutenção',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Interessante, mas faltou interatividade e envolvimento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Muito Bom, porém tem poucas atrações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text(
                        'Boas atrações, mas achei um pouco confuso',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 65), // Aumentei o espaçamento aqui
              // Campo de explicação
              const TextField(
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
