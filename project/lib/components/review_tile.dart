import 'package:flutter/material.dart';
import 'package:project/classes/review.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  TextStyle style = const TextStyle(fontFamily: "Lato");
  ReviewTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(review.title, style: style,),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            const Icon(Icons.star, color: Colors.amber),
            Text(review.rating.toString(), style: style,),
          ],
        ),
        subtitle: Text("${review.author}\n\n${review.content}", style: style,),
      ),
    );
  }
}
