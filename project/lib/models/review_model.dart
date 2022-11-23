import 'db_utils.dart';
import 'package:project/classes/movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/classes/review.dart';

class ReviewModel {
  Future<List<Review>> getMovieReviews(int movieID) async {
    List<Review> reviews = [];

    var collection = await FirebaseFirestore.instance.collection("movieReviews").get();
    for (var doc in collection.docs.where((element) => element["movie_id"] == movieID)) {
      Review review = Review.fromMap(doc.data());
      review.reference = doc.reference;
      reviews.add(review);
    }

    return reviews;
  }

  Future addMovieReview(Review review) async {
    DocumentReference reference = await FirebaseFirestore.instance.collection("movieReviews").add(review.toMap());
    review.reference = reference;
  }
}