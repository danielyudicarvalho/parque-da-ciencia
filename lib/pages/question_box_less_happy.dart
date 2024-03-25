import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxLessHappy extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxLessHappy({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<QuestionBoxLessHappy> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxLessHappy> {
  String selectedOption = '';
  List<String> options = [];  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Por que você escolheu essa opção?",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),

      content: Container(
        width: 800,
        height: 500,

        child: Column(
          children: [
            RadioListTile<String>(
              title: const Text('Variedade de atrações', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("variedade")){
                    options.removeWhere((str){
                      return str == 'variedade';
                    });
                  }else{
                    options.add("variedade");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Bom atendimento', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("atendimento")){
                    options.removeWhere((str){
                      return str == 'atendimento';
                    });
                  }else{
                    options.add("atendimento");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Boa estrutura', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 3',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("estrutura")){
                    options.removeWhere((str){
                      return str == 'estrutura';
                    });
                  }else{
                    options.add("estrutura");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Aprendizagem interessante', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 4',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("aprendizagem")){
                    options.removeWhere((str){
                      return str == 'aprendizagem';
                    });
                  }else{
                    options.add("aprendizagem");  
                  } 
                  
                });
              },
            ),
            const Spacer(),

            // Campo de explicaçao
            const TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Explique a sua escolha para nos ajudar a melhorar...",
                hintStyle: TextStyle(color: Colors.white70, fontSize: 25),
              )
            ),
            const Spacer(flex: 2,),

            // Botoes cancelar e salvar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                MyButton(text: "Cancelar", onPressed: widget.onCancel),
                const SizedBox(width: 75,),
                MyButton(text: "Salvar", onPressed: widget.onSave,),
                const Spacer()
              ]
            ),
            const Spacer(flex: 1,)
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent[400],
    );
  }
}
