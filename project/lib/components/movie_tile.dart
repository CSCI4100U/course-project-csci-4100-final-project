import 'package:flutter/material.dart';
import 'package:project/classes/movie.dart';
import 'package:project/views/movie_details.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 90,
          child: Image.network("https://image.tmdb.org/t/p/w500/${movie.poster}"),
        ) ,
        title: Text(movie.title),
        subtitle: Text("Rating: N/A, Release Date: ${movie.release}"),
      ),
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MovieDetails(movieID: movie.id, movieName: movie.title);
        }));
      },
    );
  }
}
