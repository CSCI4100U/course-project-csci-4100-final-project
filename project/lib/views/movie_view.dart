import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/models/movie_model.dart';
import 'package:project/classes/movie.dart';
import 'package:project/components/movie_tile.dart';
import 'package:project/views/add_movie_form.dart';

import '../components/drawer.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  final MoviesModel _model = MoviesModel();

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "Mov_tab.Mov_list")),
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
                  Text(FlutterI18n.translate(context, "Mov_tab.Con_fail"))
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

                    },
                    child: MovieTile(movie: snapshot.data![index]),
                  );
                }
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Movie? movie = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddMovieForm()));
          if (movie == null) {
            return;
          }
          await _model.insertMovie(movie);
          setState(() {});
        },
      ),
    );
  }

}

