import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Allow null to handle disabled state

  const MyButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: onPressed != null
          ? Colors.white
          : Colors.grey, // Change color based on enabled/disabled state
      minimumSize: const Size(230, 50), // Define o tamanho mínimo dos botões
      padding: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0088B7),
      ),
    );

    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 35,
          color: Color(0xFF0088B7),
        ),
      ),
    );
  }
}
