import 'db_utils.dart';
import 'package:project/classes/movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/fetch_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoviesModel {
  Future<List<Movie>> getAllMovies() async {
    List<Movie> movies = [];

    print("Requesting data from Firestore");
    if (FirebaseAuth.instance.currentUser == null) {
      print("Not logged in");
      return [];
    }
    var collection = await FirebaseFirestore.instance.collection("movieList").where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    print("Successfully retrieved data from Firestore");
    for (var doc in collection.docs) {
      //Movie movie = Movie.fromMap(doc.data());
      Movie movie = await getMovieFromID(doc.data()['id']);
      movie.reference = doc.reference;
      movies.add(movie);
    }
    return movies;
  }

  Future<Movie> getMovieFromID(int id) async {
    return await Fetch.fetchMovieDetails(id);
  }

  Future insertMovie(Movie movie) async {
    DocumentReference ref = await FirebaseFirestore.instance.collection("movieList").add(movie.toMap());
    movie.reference = ref;
  }
}