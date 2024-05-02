import 'package:flutter/material.dart';
import 'package:pc_app/pages/login_page.dart';

class ReviewsSentPage extends StatelessWidget {
  const ReviewsSentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulating fetching total reviews (replace this with actual logic)
    int totalReviews = 10;

    // Delay for 3 seconds before redirecting to login page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews Sent'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Reviews: $totalReviews',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
