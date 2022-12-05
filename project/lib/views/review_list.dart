import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/classes/review.dart';
import 'package:project/components/review_tile.dart';
import 'package:project/models/review_model.dart';
import 'package:project/views/add_review_form.dart';

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
        title: Text(FlutterI18n.translate(context, "Review.Rev")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReview,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Review>>(
        future: _model.getMovieReviews(widget.movieID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.question_mark, color: Colors.blue, size: 50.0),
                  Text(FlutterI18n.translate(context, "Review.No_rev"))
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ReviewTile(review: snapshot.data![index]);
            },
            separatorBuilder: (context, index) {
              return const Padding(padding: EdgeInsets.symmetric(vertical: 5.0));
            },
          );
        }
      ),
    );
  }

  void _addReview() async {
    Review? review = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReviewForm(id: widget.movieID, title: widget.movieName)));
    if (review != null) {
      await _model.addMovieReview(review);
      setState(() {});
    }
  }
}
