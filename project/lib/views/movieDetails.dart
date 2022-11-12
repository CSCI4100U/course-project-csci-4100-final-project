import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, required this.movieID, required this.movieName }) : super(key: key);
  final int? movieID;
  final String? movieName;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.movieName}"),
      ),

    );
  }
}
