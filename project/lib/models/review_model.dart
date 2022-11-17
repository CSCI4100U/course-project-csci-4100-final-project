import 'db_utils.dart';
import 'package:project/classes/movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/classes/review.dart';

class ReviewModel {
  Future<List<Review>> getMovieReviews(int movieID) async {
    List<Review> reviews = [];

    var collection = await FirebaseFirestore.instance.collection("movieReviews").get();
    for (var doc in collection.docs/*.where((element) => element["id"] == movieID)*/) {
      Review review = Review.fromMap(doc.data());
      reviews.add(review);
    }

    return reviews;
  }
}