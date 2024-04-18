import 'package:flutter/material.dart';
import 'package:pc_app/pages/login_page.dart';
import 'package:pc_app/pages/options_page.dart';


class ReviewsSentPage extends StatelessWidget {


  const ReviewsSentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews Sent'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reviews sent to email ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to OptionPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OptionPage()),
                );
              },
              child: Text('Option Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Close the app
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text('Encerrar passeio'),
            ),
          ],
        ),
      ),
    );
  }
}
