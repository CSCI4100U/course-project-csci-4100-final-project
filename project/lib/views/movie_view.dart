import 'package:flutter/material.dart';
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
        title: const Text("My Movies List"),
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
                children: const [
                  Icon(Icons.error, color: Colors.red, size: 50.0),
                  Text("Failed to connect to cloud storage. Please try again later.")
                ],
              );
            } else if (!snapshot.hasData) {
              // Loading
              return const CircularProgressIndicator();
            } else {
              // Movie list
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return MovieTile(movie: snapshot.data![index]);
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

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children:[
              Text("Movies Search"),
                 TextFormField(
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     labelText: 'Movie Title',
                   )
                 ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Year of Movie',
                  )
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Actor',
                  )
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Director',
                  )
              )
        ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{
            showSnackBarMovie(context),
          },
          child: const Icon(Icons.search)



      ),
    );

    }
  void showSnackBarMovie(BuildContext context){
    var snackBar = SnackBar(
        content: Text("Searching for movie..."),
        action: SnackBarAction(
          label: "OK",
          onPressed:() {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
}

