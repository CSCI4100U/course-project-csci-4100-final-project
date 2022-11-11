import 'db_utils.dart';
import 'package:project/classes/movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoviesModel {
  Future<List<Movie>> getAllMovies() async {
    List<Movie> movies = [];

    print("Requesting data from Firestore");
    var collection = await FirebaseFirestore.instance.collection("movieList").get();
    print("Successfully retrieved data from Firestore");
    for (var doc in collection.docs) {
      movies.add(Movie.fromMap(doc.data()));
    }
    return movies;
  }
}