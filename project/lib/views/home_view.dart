import 'package:flutter/material.dart';
import '../classes/trending.dart';
import 'package:project/components/movieTile.dart';
import 'dart:async';
import 'movie_details.dart';
import '../models/fetch_data.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _MyAppState();
}
class _MyAppState extends State<HomeView> {
  final _fetch = Fetch().fetchTrending();

  @override
  Widget build(BuildContext context) {
    int? selectedMovieID;
    String? selectedMovieName;
    return Center(
      child: FutureBuilder<List<Trending>>(
        future: _fetch,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                      onTap: () {
                        selectedMovieID = snapshot.data![index].id;
                        selectedMovieName = snapshot.data![index].title;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text('Getting Movie Info for $selectedMovieName')
                            ));
                          Future.delayed(
                              const Duration(seconds: 2),
                              (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(movieID: selectedMovieID, movieName: selectedMovieName,)));
                              }
                          );
                        },
                      child: MovieTile(
                        title: snapshot.data![index].title,
                        release: snapshot.data![index].release,
                        poster: snapshot.data![index].poster,
                        rating: snapshot.data![index].rating,
                      )
                  );
                });
          }},
      ),
    );
  }
}

