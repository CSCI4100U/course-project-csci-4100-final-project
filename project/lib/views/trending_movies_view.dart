import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/classes/movie.dart';
import 'package:project/components/drawer.dart';
import 'package:project/views/trending_books_view.dart';
import '../classes/trending.dart';
import 'package:project/components/movie_tile.dart';
import 'dart:async';
import 'movie_details.dart';
import '../models/fetch_data.dart';
import 'package:project/views/chart_page.dart';

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({Key? key}) : super(key: key);
  @override
  State<TrendingMovies> createState() => _MyAppState();
}
class _MyAppState extends State<TrendingMovies> {
  List<Trending<Movie>> _trending = [];
  String _value = "movie";
  @override
  Widget build(BuildContext context) {
    int? selectedMovieID;
    String? selectedMovieName;
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: ThemeData.dark(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _value,
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'movie',
                  child: Text('Trending Movies'),
                ),
                DropdownMenuItem(
                  value: 'book',
                  child: Text('Trending Books'),
                )
              ],
              onChanged: (String? value) {
                setState(() {
                  _value = value!;
                  if(_value == "book"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                TrendingBooks()
                        ));
                  }
                });
              },
            ),
          ),
        ),
        // title: Text(FlutterI18n.translate(context, "Home.Trending")),
        actions: [
          IconButton(
            icon: const Icon(Icons.insert_chart),
            onPressed: () {
              if (_trending.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChartPage(trending: _trending)));
              }
            },
          )
        ],
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
              _trending = snapshot.data!;
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

