import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:project/classes/book_author.dart';
import 'package:project/classes/movie.dart';
import '../classes/book.dart';
import '../classes/mapMarker.dart';
import '../classes/movie_cast.dart';
import '../classes/trending.dart';
import 'package:project/classes/book_author.dart';

class Fetch{
  // Stores movies from My List after the initial load to prevent unnecessary API calls
  static Map<int, Movie> cachedMovies = {};
  // Stores all trending movies after the initial load to prevent unnecessary API calls
  static List<Trending<Movie>> cachedTrendingMovies = [];
  // The timestamp of when the cachedTrendingMovies map was last updated
  static DateTime cachedTrendingMoviesLastUpdated = DateTime(0);

  // Stores books from My List after the initial load to prevent unnecessary API calls
  static Map<int, Book> cachedBooks = {};
  // Stores all trending books after the initial load to prevent unnecessary API calls
  static List<Book> cachedTrendingBooks = [];
  // The timestamp of when the cachedTrendingBooks map was last updated
  static DateTime cachedTrendingBooksLastUpdated = DateTime(0);

  // Stores all cinema loctaions after the initial load to prevent unnecessary API calls
  static List<GeoLocation> cachedCinemas = [];
  static List<GeoLocation> cachedBookstores = [];
  // The timestamp of when the cachedTrendingBooks map was last updated
  static DateTime cachedGeolocationLastUpdated = DateTime(0);
  static DateTime cachedGeolocationLastUpdatedBooks = DateTime(0);


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

  static Future<List<Movie>> fetchMoviesFromSearchQuery(String query) async {
    if (query == '') {
      return [];
    }

    List<Movie> results = [];

    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/search/movie/?query=$query&api_key=3504ebf3ee269a0d7dbc3e0e586c0768&language=en-US')
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      for (Map entry in data['results']) {
        results.add(Movie.fromMap(entry));
      }
    }

    return results;
  }

  //BOOK FETCH FUNCTIONS
  static Future<Book> fetchBookDetails(String id) async {
    var response = await http
        .get(Uri.parse('https://openlibrary.org/works/$id.json')
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (data['type']['key'] == '/type/redirect') {
        String loc = data['location'];
        return fetchBookDetails(loc.substring(loc.lastIndexOf('/') + 1));
      }
      List<String> authors = [];
      for (Map data in data['authors']) {
        String key = data['author']['key'];
        authors.add(key.substring(key.lastIndexOf('/') + 1));
      }
      Book book = Book.fromMap(id, data);
      book.authors = authors;
      return book;
    } else {
      throw Exception('Failed to load book');
    }
  }

  static Future<List<Book>> fetchTrendingBooks() async {
    // If the last time the trending movies were updated was below a threshold,
    // return the cached version
    DateTime now = DateTime.now();
    if (now.difference(cachedTrendingBooksLastUpdated).inDays < 1) {
      return cachedTrendingBooks;
    }

    // Enough time has passed, so refresh trending movies from the API
    cachedTrendingBooksLastUpdated = now;
    var response = await http
        .get(Uri.parse('https://openlibrary.org/trending/weekly.json')
    );
    if (response.statusCode == 200) {
      List userMap = jsonDecode(response.body)['works'];
      List<Book> trending = [];
      for (int i = 0; i < 20; i++){
        Map data = userMap[i];
        //Book book = Book.fromMap(item);
        String loc = data['key'];
        Book book = await fetchBookDetails(loc.substring(loc.lastIndexOf('/') + 1));
        //Book book = await fetchBookDetails(data['key']['openlibrary_work']);
        trending.add(book);
      }
      cachedTrendingBooks = trending;
      return trending;
    } else {
      throw Exception('Failed to load book');
    }
  }

  static Future<List<Book>> fetchBooksFromSearchQuery(String query) async {
    if (query == '') {
      return [];
    }

    List<Book> results = [];

    var response = await http
        .get(Uri.parse('http://openlibrary.org/search.json?q=$query')
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      for (int i = 0; i < 10; i++) {
        if (i >= data['numFound']) {
          break;
        }
        Map entry = data['docs'][i];
        String id = entry['key'];
        results.add(await fetchBookDetails(id.substring(id.lastIndexOf('/') + 1)));
      }
    }

    return results;
  }

  static Future<List<BookAuthor>> fetchBookAuthors(Book book) async {
    List<BookAuthor> result = [];

    if (book.authors == null) {
      return [];
    }
    for (String author in book.authors!) {
      var response = await http
          .get(Uri.parse('http://openlibrary.org/authors/$author.json')
      );
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        result.add(BookAuthor(name: data['name']));
      }
    }

    return result;
  }

  //LOCATION FETCH FUNCTIONS
  static Future<List<GeoLocation>> fetchLocations(String accessTokFind, LatLng l) async {

    DateTime now = DateTime.now();
    if (now.difference(cachedGeolocationLastUpdated).inDays < 1) {
      return cachedCinemas;
    }
    cachedGeolocationLastUpdated = now;
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
      cachedCinemas = nearby;
      return nearby;
    }else {
      throw Exception('Failed to load nearby cinemas');
    }
  }
  static Future<List<GeoLocation>> fetchBookstores(String accessTokFind, LatLng l) async {
    List<GeoLocation> nearby = [];
    double lat = l.latitude;
    double long = l.longitude;

    DateTime now = DateTime.now();
    if (now.difference(cachedGeolocationLastUpdatedBooks).inDays < 1) {
      return cachedBookstores;
    }
    cachedGeolocationLastUpdatedBooks = now;
    //print('https://api.tomtom.com/search/2/search/cinema.json?key=$accessTokFind&lat=$lat&lon=$long&radius=25000&language=en-US');
    var response = await http
        .get(Uri.parse('https://api.tomtom.com/search/2/search/bookstore.json?key=$accessTokFind&lat=$lat&lon=$long&radius=15000&language=en-US')
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
      cachedBookstores = nearby;
      return nearby;
    }else {
      throw Exception('Failed to load nearby cinemas');
    }
  }


}
