import 'package:flutter/material.dart';
import '../classes/movie.dart';
import 'package:project/components/movieTile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movieDetails.dart';

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
    String selectedMovie;
    return Center(
      child: FutureBuilder<List<Movie>>(
        future: fetchAlbum(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Text("Loading...");
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return InkWell(
                      onTap: () {
                        selectedMovie = snapshot.data![index].title;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text('Getting Movie Info for $selectedMovie')
                            ));
                        setState(() {

                          print("Selected Movie ${snapshot.data![index].title}");
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(name: selectedMovie,)));
                        },
                      highlightColor: Colors.red,
                      child: MovieTile(
                        title: snapshot.data![index].title,
                        release: snapshot.data![index].release,
                        poster: snapshot.data![index].poster,
                      )
                    );
                }
            );
          }
        },
      ),
    );
  }
}

