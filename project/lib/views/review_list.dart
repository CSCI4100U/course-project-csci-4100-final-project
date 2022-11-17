import 'package:flutter/material.dart';
import 'package:project/classes/review.dart';
import 'package:project/components/review_tile.dart';
import 'package:project/models/review_model.dart';

class ReviewList extends StatefulWidget {
  final String movieName;
  final int movieID;

  const ReviewList({Key? key, required this.movieName, required this.movieID}) : super(key: key);

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final ReviewModel _model = ReviewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.movieName} Reviews"),
      ),
      body: FutureBuilder<List<Review>>(
        future: _model.getMovieReviews(widget.movieID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ReviewTile(review: snapshot.data![index]);
            },
          );
        }
      ),
    );
  }
}
