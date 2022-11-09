import 'package:flutter/material.dart';
import 'movie.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;




class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _MyAppState();
}
class _MyAppState extends State<HomeView> {

  Future<Movie> fetchAlbum() async {
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/day?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );

    if (response.statusCode == 200) {
      print("getting data");
      var parsedListJson = jsonDecode(response.body);
      // print("$parsedListJson");
      var results = parsedListJson['results'];
      List <Movie> trending = [];
      for(var m in results){
        Movie 
      }

      return (Movie(results: "x", id: 123, title: "FFFF"));
      // List<Movie> itemsList = List<Movie>.from(parsedListJson.map<Item>((dynamic i) => Item.fromJson(i)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Movie>(
        future: fetchAlbum(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.title);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

