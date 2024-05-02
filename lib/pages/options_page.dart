import 'package:flutter/material.dart';
import 'package:pc_app/pages/home_page.dart';
import 'package:pc_app/pages/review_page.dart';
import 'package:pc_app/pages/simple_nps_page.dart'; // Import SimpleNpsPage

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text('NPS Survey'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple NPS Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,

              ),
              onPressed: () {
                // Navigate to Simple NPS Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SimpleNpsPage()),
                );
              },
              child: const Text('Feedback Simples'),
            ),
            const SizedBox(height: 20),

            // Complex NPS Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Navigate to Home Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Feedback do Responsável'),
            ),
            const SizedBox(height: 20),

            // Submit Data Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,

              ),
              onPressed: () {
                // Handle Submit Data action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewPage()),
                );
              },
              child: const Text('Enviar Resultados'),
            ),
          ],
        ),
      ),
    );
  }
}
