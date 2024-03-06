import 'package:flutter/material.dart';
import 'package:pc_app/pages/question_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Methods
  void openQuestionBox(){
    showDialog(
      context: context,
      builder: (context){
        return QuestionBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,

      appBar: AppBar(
        backgroundColor: Colors.blueAccent[400],
        centerTitle: true,

        title: const Text(
          "Parque Da Ciência",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),

      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Spacer(flex: 2,),
            IconButton(
              onPressed: openQuestionBox,
              icon: Image.asset('lib/images/feliz.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox,
              icon: Image.asset('lib/images/meiofeliz.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox,
              icon: Image.asset('lib/images/medio.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox,
              icon: Image.asset('lib/images/meioruim.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),

            const Spacer(flex: 1,),
            IconButton(
              onPressed: openQuestionBox,
              icon: Image.asset('lib/images/ruim.jpeg'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(25)),
              ),
            ),
            const Spacer(flex: 2,),
          ],
        ),
      ),

    );
  }
}
