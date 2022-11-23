import 'package:flutter/material.dart';
import '../classes/movie.dart';
import '../models/fetch_data.dart';
import 'package:project/views/review_list.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, required this.movieID, required this.movieName})
      : super(key: key);
  final int? movieID;
  final String? movieName;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final _model = Fetch();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.movieName}"),
        ),
        body: FutureBuilder<Movie>(
            future: _model.fetchMovieDetails(widget.movieID),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        height: 400,
                        child: Image.network(
                            "https://image.tmdb.org/t/p/w500/${snapshot.data!.poster}"),
                      ),
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${snapshot.data!.overview}",
                        style: const TextStyle(fontSize: 20, fontFamily: 'Lato'),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        child: const Text("Reviews", style: TextStyle(fontSize: 18)),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReviewList(movieName: snapshot.data!.title!, movieID: snapshot.data!.id!))),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}