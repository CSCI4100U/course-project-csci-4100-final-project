import 'package:flutter/material.dart';
import '../classes/movie.dart';
import 'package:project/components/movieTile.dart';
import 'dart:async';
import 'movieDetails.dart';
import '../models/fetchData.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _MyAppState();
}
class _MyAppState extends State<HomeView> {
  final _fetch = Fetch().fetchTrending();

  @override
  Widget build(BuildContext context) {
    int? _selectedMovieID;
    String? _selectedMovieName;
    return Center(
      child: FutureBuilder<List<Movie>>(
        future: _fetch,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Text("Loading...");
          }
          else {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                      onTap: () {
                        _selectedMovieID = snapshot.data![index].id;
                        _selectedMovieName = snapshot.data![index].title;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text('Getting Movie Info for $_selectedMovieName')
                            ));
                          Future.delayed(const Duration(seconds: 2),
                              (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(movieID: _selectedMovieID, movieName: _selectedMovieName,)));
                              }
                          );

                        },
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

