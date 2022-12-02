import 'package:flutter/material.dart';
import 'package:project/classes/review.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(review.title),
        subtitle: Text("${review.author}\n\n${review.content}"),
      ),
    );
  }
}
