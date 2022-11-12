import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String title;
  final String release;
  final String poster;

  const MovieTile({Key? key, required this.title, required this.release, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 90,
        child: Image.network("https://image.tmdb.org/t/p/w500/$poster"),
      ) ,
      title: Text(title),
      subtitle: Text(release),
    );
  }
}
