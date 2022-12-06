import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/models/movie_model.dart';
import 'package:project/classes/movie.dart';
import 'package:project/components/movie_tile.dart';
import 'package:project/views/add_movie_form.dart';

import '../components/drawer.dart';
import '../models/movie_search_delegate.dart';
import 'movie_details.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  final MoviesModel _model = MoviesModel();
  DateTimeRange range = DateTimeRange(
      start: DateTime(1970, 1, 1),
      end: DateTime(2024, 1, 1)
  );

  @override Widget build(BuildContext context) {
    final start = range.start;
    final finish = range.end;
    final rangeDiff = range.duration;
    int? selectedMovieId;
    String? selectedMovieName;
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "Mov_tab.Mov_list")),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              var movie = await showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
              if (movie != null) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                    MovieDetails(movieID: movie!.id, movieName: movie.title)));
              }
            },
          ),
          IconButton(
              onPressed: pickDate,
              icon: const Icon(Icons.filter),
          )
        ],
      ),
      drawer: NavDrawer(),
      body: Center(
            child: FutureBuilder<List<Movie>>(
              future: _model.getAllMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // Error
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 50.0),
                      Text(FlutterI18n.translate(context, "Mov_tab.Con_fail")),
                    ],
                  );
                } else if (!snapshot.hasData) {
                  // Loading
                  return const CircularProgressIndicator();
                } else {
                  // Movie list
                  return ListView.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          selectedMovieId = snapshot.data![index].id;
                          selectedMovieName = snapshot.data![index].title;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text('Getting Movie Info for $selectedMovieName')
                              ));
                          Future.delayed(
                              const Duration(seconds: 2),
                                  () async {
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(movieID: selectedMovieId!, movieName: selectedMovieName,)));
                              }
                          );
                        },
                        child: MovieTile(movie: snapshot.data![index]),
                      );
                    }
                  );
                }
              },
            ),

          ),
    );
  }
  Future pickDate() async{
    DateTimeRange? newRange = await showDateRangePicker(
        context: context,
        initialDateRange: range,
        firstDate: DateTime(1950),
        lastDate: DateTime(2025),
    );
    if (newRange == null)
      return;
    setState(() => range = newRange);
  }

}

