import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String title;
  final String release;
  final String poster;
  final num? rating;

  const MovieTile({Key? key, required this.title, required this.release, required this.poster, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 90,
        child: Image.network("https://image.tmdb.org/t/p/w500/$poster"),
      ) ,
      title: Text(title),
      subtitle: Text("Rating: $rating, Release Date: $release"),
    );
  }
}