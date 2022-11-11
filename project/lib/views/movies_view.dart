import 'package:flutter/material.dart';
import 'package:project/models/movies_model.dart';
import 'package:project/classes/movie.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  final MoviesModel _model = MoviesModel();

  @override Widget build(BuildContext context) {
    return Center(
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

