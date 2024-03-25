import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxMoreBad extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxMoreBad({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<QuestionBoxMoreBad> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxMoreBad> {
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
              title: const Text('Acho que o parque está um pouco desatualizado e mal conservado', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("mal conservado")){
                    options.removeWhere((str){
                      return str == 'mal conservado';
                    });
                  }else{
                    options.add("mal conservado");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Acho que a falta de mais funcionários prejudicou o parque ', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("falta funcionários")){
                    options.removeWhere((str){
                      return str == 'falta funcionários';
                    });
                  }else{
                    options.add("falta interatividade");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Acho que tem poucas atrações', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 3',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("poucas atrações")){
                    options.removeWhere((str){
                      return str == 'poucas atrações';
                    });
                  }else{
                    options.add("poucas atrações");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('A falta de estrutura do parque prejudicou a minha experiência', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 4',
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
