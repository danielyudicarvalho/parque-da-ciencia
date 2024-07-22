import 'package:flutter/material.dart';

class GenericPopUp extends StatefulWidget {
  final String image;
  final String frase;

  const GenericPopUp({Key? key, required this.image, required this.frase}) : super(key: key);

  @override
  _GenericPopUpState createState() => _GenericPopUpState();
}

class _GenericPopUpState extends State<GenericPopUp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
          backgroundColor: Colors.white,
        
          content: SizedBox(
              width: 800,
              height: 400,
        
              child: SingleChildScrollView(
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
                ),
              )
          ),
        ),
    );
  }
}
