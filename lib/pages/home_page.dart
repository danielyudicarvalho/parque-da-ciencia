import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          IconButton(
            onPressed: () {print("click");},
            icon: Image.asset('lib/images/feliz.jpeg'),
            padding: EdgeInsets.all(20),
          ),
          IconButton(
            onPressed: () {print("click");},
            icon: Image.asset('lib/images/meiofeliz.jpeg'),
            padding: EdgeInsets.all(20),
          ),
          IconButton(
            onPressed: () {print("click");},
            icon: Image.asset('lib/images/medio.jpeg'),
            padding: EdgeInsets.all(20),
          ),
          IconButton(
            onPressed: () {print("click");},
            icon: Image.asset('lib/images/medio.jpeg'),
            padding: EdgeInsets.all(20),
          ),
          IconButton(
            onPressed: () {print("click");},
            icon: Image.asset('lib/images/meioruim.jpeg'),
            padding: EdgeInsets.all(20),
          ),
          IconButton(
            onPressed: () {print("click");},
            icon: Image.asset('lib/images/ruim.jpeg'),
            padding: EdgeInsets.all(20),
          ),
        ],
      ),

    );
  }
}
