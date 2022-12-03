import 'package:flutter/material.dart';
import 'package:project/classes/movie.dart';
import 'package:project/components/drawer.dart';
import '../classes/trending.dart';
import 'package:project/components/movie_tile.dart';
import 'dart:async';
import 'movie_details.dart';
import '../models/fetch_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomeView> createState() => _MyAppState();
}
class _MyAppState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    int? selectedMovieID;
    String? selectedMovieName;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
        drawer: const NavDrawer(),
        body: Center(
        child: FutureBuilder<List<Trending<Movie>>>(
          future: Fetch.fetchTrendingMovies(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                        onTap: () {
                          selectedMovieID = snapshot.data![index].base.id;
                          selectedMovieName = snapshot.data![index].base.title;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text('Getting Movie Info for $selectedMovieName')
                              ));
                            Future.delayed(
                                const Duration(seconds: 2),
                                () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(movieID: selectedMovieID, movieName: selectedMovieName,)));
                                }
                            );
                          },
                        child: MovieTile(movie: snapshot.data![index].base, rating: snapshot.data![index].rating),
                    );
                  });
            }},
        ),
      ),
    );
  }
}

