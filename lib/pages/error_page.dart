import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String image;
  final String frase;

  const ErrorPage({Key? key, required this.image, required this.frase}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Colors.white,
        
          content: SizedBox(
              width: 800,
              height: 400,
        
              child: Column(
                  children: [
                    Image.asset(
                      widget.image,
                      width: 350, // ajuste o tamanho da imagem conforme necessário
                      height: 350,
                    ),
        
                    const SizedBox(),
        
                    Text(
                      widget.frase,
                      style: TextStyle(
                          color: Color(0xFF0088B7),
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
        
                    const SizedBox(),
                  ]
              )
          ),
        ),
      ),
    );
  }
}
