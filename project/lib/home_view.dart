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

  Future<List<Movie>> fetchAlbum() async {
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=3504ebf3ee269a0d7dbc3e0e586c0768')
    );

    if (response.statusCode == 200) {
      List userMap =  jsonDecode(response.body)['results'];
      print(userMap);

      // var x = userMap.cast<String, String>();
      // print(x);

      List<Movie> trending = [];
      for (var item in userMap){
        trending.add(Movie.fromMap(item));
      }
      return trending;
    }else {
      throw Exception('Failed to load movies');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Movie>>(
        future: fetchAlbum(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.data == null) {
            return Text("Loading...");
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 90,
                      child: Image.network("https://image.tmdb.org/t/p/w500/${snapshot.data![index].poster}"),
                    ) ,
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].release) ,
                  );
                }
            );
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

