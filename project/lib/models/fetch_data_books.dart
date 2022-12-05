/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/classes/movie.dart';
import '../classes/movie_cast.dart';
import '../classes/trending.dart';
import 'package:project/classes/book.dart';

class FetchBooks{
  // Stores movies from My List after the initial load to prevent unnecessary API calls
  static Map<int, Book> cachedBooks = {};
  // Stores all trending movies after the initial load to prevent unnecessary API calls
  static List<Trending<Book>> cachedTrendingBooks = [];
  // The timestamp of when the cachedTrendingMovies map was last updated
  static DateTime cachedTrendingBooksLastUpdated = DateTime(0);

  Future<List<Trending<Book>>> fetchTrendingBooks() async {
    // If the last time the trending movies were updated was below a threshold,
    // return the cached version
    DateTime now = DateTime.now();
    if (now.difference(cachedTrendingBooksLastUpdated).inMinutes < 10) {
      return cachedTrendingBooks;
    }

    // Enough time has passed, so refresh trending movies from the API
    cachedTrendingBooksLastUpdated = now;
    var response = await http
    .get(Uri.parse('https://openlibrary.org/works/OL5819895W.json')
    //.get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );
    if (response.statusCode == 200) {
      List userMap = jsonDecode(response.body)['description']['title'];
      List<Book<Book>> books = [];
      for (var item in userMap){
        Book book = Book.fromMap(item);
        String description =(item['description']);
        String title = (item['title']);
        // double rating = (item['title']);
        Book<Book> t = Book(title: title, description: description);
        books.add(t);
      }
      cachedTrendingBooks = books;
      return books;
    } else {
      throw Exception('Failed to load trending books');
    }
  }

  /*Future<List<Trending<Book>>> fetchTrendingBooks() async {

  }*/

  Future<Book> fetchMovieDetails(int? id) async {
    if (cachedBooks.containsKey(id!)) {
      return cachedBooks[id]!;
    }

    String getId = id.toString();
    print('https://openlibrary.org/works/OL5819895W.json');
    //print('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US');
    var response = await http
        .get(Uri.parse('https://openlibrary.org/works/OL5819895W.json')
    );
    if (response.statusCode == 200) {
      var userMap =  jsonDecode(response.body);
      Book movie = Book.fromMap(userMap);
      cachedBooks[id] = movie;
      return movie;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }
//
// Future<MovieCast> fetchMovieCast(int? id) async {
//   String getId = id.toString();
//   print('https://api.themoviedb.org/3/movie/$getId/credits?api_key=<<api_key>>&language=en-US');
//   var response = await http
//       .get(Uri.parse('https://api.themoviedb.org/3/movie/$getId/credits?api_key=<<api_key>>&language=en-US')
//   );
//   if (response.statusCode == 200) {
//     List userMap =  jsonDecode(response.body)['cast'];
//     List<MovieCast> cast = [];
//     for (var item in userMap){
//       trending.add(Cast.fromMap(item));
//     }
//     return trending;
//   }else {
//     throw Exception('Failed to load trending movies');
//   }
// }

}

*/