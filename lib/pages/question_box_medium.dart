import 'package:flutter/material.dart';
import '../util/my_button.dart';

class QuestionBoxMedium extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const QuestionBoxMedium({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<QuestionBoxMedium> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBoxMedium> {
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
              title: const Text('boa variedade, porém falta manutenção ', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("manutenção")){
                    options.removeWhere((str){
                      return str == 'manutenção';
                    });
                  }else{
                    options.add("manutenção");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Interessante, mas faltou interatividade e envolvimento', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("falta interatividade")){
                    options.removeWhere((str){
                      return str == 'falta interatividade';
                    });
                  }else{
                    options.add("falta interatividade");  
                  } 
                  
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Muito, mas acho que tem poucas atrações', style: TextStyle(color: Colors.white, fontSize: 25),),
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
              title: const Text('Boas atrações, mas achei um pouco confuso pois falta instruções', style: TextStyle(color: Colors.white, fontSize: 25),),
              value: 'Opção 4',
              groupValue: selectedOption,
              onChanged: (value) {
                setState((){
                  selectedOption = value!;
                  if(options.contains("confuso")){
                    options.removeWhere((str){
                      return str == 'confuso';
                    });
                  }else{
                    options.add("confuso");  
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
