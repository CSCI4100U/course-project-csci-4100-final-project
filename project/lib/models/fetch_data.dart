import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:project/classes/movie.dart';
import '../classes/book.dart';
import '../classes/mapMarker.dart';
import '../classes/movie_cast.dart';
import '../classes/trending.dart';
import '../classes/trending_book.dart';

class Fetch{
  // Stores movies from My List after the initial load to prevent unnecessary API calls
  static Map<int, Movie> cachedMovies = {};
  // Stores all trending movies after the initial load to prevent unnecessary API calls
  static List<Trending<Movie>> cachedTrendingMovies = [];
  // The timestamp of when the cachedTrendingMovies map was last updated
  static DateTime cachedTrendingMoviesLastUpdated = DateTime(0);

  //MOVIE FETCH FUNCTIONS
  static Future<List<Trending<Movie>>> fetchTrendingMovies() async {
    // If the last time the trending movies were updated was below a threshold,
    // return the cached version
    DateTime now = DateTime.now();
    if (now.difference(cachedTrendingMoviesLastUpdated).inDays < 1) {
      return cachedTrendingMovies;
    }

    // Enough time has passed, so refresh trending movies from the API
    cachedTrendingMoviesLastUpdated = now;
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );
    if (response.statusCode == 200) {
      List userMap = jsonDecode(response.body)['results'];
      List<Trending<Movie>> trending = [];
      for (var item in userMap){
        Movie movie = Movie.fromMap(item);
        double rating = (item['vote_average'] / 2);
        Trending<Movie> t = Trending<Movie>(base: movie, rating: rating);
        trending.add(t);
      }
      cachedTrendingMovies = trending;
      return trending;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  static Future<Movie> fetchMovieDetails(int? id) async {
    if (cachedMovies.containsKey(id!)) {
      return cachedMovies[id]!;
    }

    String getId = id.toString();
    print('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US');
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$getId?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US')
    );
    if (response.statusCode == 200) {
      var userMap =  jsonDecode(response.body);
      Movie movie = Movie.fromMap(userMap);
      cachedMovies[id] = movie;
      return movie;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }

  static Future<List<MovieCast>> fetchMovieCast(int? id) async {

    String getId = id.toString();
    //print('https://api.themoviedb.org/3/movie/$getId/credits?api_key=<<api_key>>&language=en-US');
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$getId/credits?api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US')
    );
    if (response.statusCode == 200) {
      List userMap =  jsonDecode(response.body)['cast'];
      List<MovieCast> cast = [];
      for (var item in userMap){
        cast.add(MovieCast.fromMap(item));
      }
      return cast;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }

  //BOOK FETCH FUNCTIONS
  static Future<Book> fetchBookDetails(String id) async {
    var response = await http
        .get(Uri.parse('https://openlibrary.org/works/$id.json')
    );
    if (response.statusCode == 200) {
      Map raw = jsonDecode(response.body);
      print(raw['title']);
      print(raw['description']);
      Book book = Book(
        id: id,
        title: raw['title'],
        description: raw['description'] != null ? raw['description']['value'] : 'No description found.',
      );
      return book;
    } else {
      throw Exception('Failed to load book');
    }
  }

  static Future<List<TrendingBook>> fetchTrendingBooks() async {
    var response = await http
        .get(Uri.parse('https://openlibrary.org/trending/weekly.json')
    );
    if (response.statusCode == 200) {
      List userMap = jsonDecode(response.body)['works'];
      List<TrendingBook> trending = [];
      for (var item in userMap){
        TrendingBook book = TrendingBook.fromMap(item);
        trending.add(book);
      }
      return trending;
    } else {
      throw Exception('Failed to load book');
    }
  }

  //LOCATION FETCH FUNCTIONS
  static Future<List<GeoLocation>> fetchLocations(String accessTokFind, LatLng l) async {
    List<GeoLocation> nearby = [];
    double lat = l.latitude;
    double long = l.longitude;
    //print('https://api.tomtom.com/search/2/search/cinema.json?key=$accessTokFind&lat=$lat&lon=$long&radius=25000&language=en-US');
    var response = await http
        .get(Uri.parse('https://api.tomtom.com/search/2/search/cinema.json?key=$accessTokFind&lat=$lat&lon=$long&radius=15000&language=en-US')
    );
    if (response.statusCode == 200) {
      var userMap =  jsonDecode(response.body)['results'];
      for (var item in userMap){
        var nameData = item["poi"];
        MarkerTitle name = MarkerTitle.fromMap(nameData);
        var addressData = item["address"];
        MarkerAddress add = MarkerAddress.fromMap(addressData);
        var locData = item["position"];
        MarkerLocation loc = MarkerLocation.fromMap(locData);
        GeoLocation G = GeoLocation(name: name.title, address: add.address, latlng: LatLng(loc.lat, loc.long));
        nearby.add(G);
      }
      return nearby;
    }else {
      throw Exception('Failed to load trending movies');
    }
  }


}
