import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        bool isPositive = review['isPositive'] == 1;
        return ListTile(
          title: Text('Review: ${review['review']}'),
          subtitle: Text(isPositive ? 'Positive' : 'Negative'),
        );
      },
    );
  }
}
