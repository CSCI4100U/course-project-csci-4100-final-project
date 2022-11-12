import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/classes/movie.dart';

class Fetch{

  Future<List<Movie>> fetchTrending() async {
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );
    if (response.statusCode == 200) {
      List userMap =  jsonDecode(response.body)['results'];
      List<Movie> trending = [];
      for (var item in userMap){
        trending.add(Movie.fromMap(item));
      }
      return trending;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }


}
