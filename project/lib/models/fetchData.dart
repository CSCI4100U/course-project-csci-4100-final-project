import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/classes/movie.dart';
import '../classes/movieCast.dart';
import '../classes/trending.dart';

class Fetch{

  Future<List<Trending>> fetchTrending() async {
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );
    if (response.statusCode == 200) {
      List userMap =  jsonDecode(response.body)['results'];
      List<Trending> trending = [];
      for (var item in userMap){
        trending.add(Trending.fromMap(item));
      }
      return trending;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<Movie> fetchMovieDetails(int? id) async {
    String getId = id.toString();
    print('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US');
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US')
    );
    if (response.statusCode == 200) {
      var userMap =  jsonDecode(response.body);
      Movie movie = Movie.fromMap(userMap);
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
