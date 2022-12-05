import 'package:flutter/material.dart';
import 'package:project/classes/movie.dart';
import 'package:project/views/movie_details.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final double? rating;

  const MovieTile({Key? key, required this.movie, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          width: 40,
          height: 90,
          child: Image.network("https://image.tmdb.org/t/p/w500/${movie.poster}"),
        ) ,
        title: (rating == null) ?
          Text(movie.title)
        :
          Row(
            children: [
              Expanded(
                child: Text(movie.title),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              const Icon(Icons.star, color: Colors.amber),
              Text(rating!.toStringAsFixed(1)),
            ],
          ),
        subtitle: Text("Release Date: ${movie.release}"),
      );
  }
}
