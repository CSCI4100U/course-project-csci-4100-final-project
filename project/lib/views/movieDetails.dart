import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),

    );
  }
}
