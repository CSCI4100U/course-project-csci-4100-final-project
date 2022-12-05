import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.movieName}"),
        ),
        body: FutureBuilder<Movie>(
            future: Fetch.fetchMovieDetails(widget.movieID),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final video = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=YMx8Bbev6T4&ab_channel=FlutterUIDev");
                return ListView(
                  children: [
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.fromLTRB(5, 40, 10, 10)),
                        Text(
                          snapshot.data!.title,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.fromLTRB(5, 0, 10, 10)),
                        Text(
                          " ${snapshot.data!.release} - ${snapshot.data!.runtime} mins - ${snapshot.data!.status} ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                                initialVideoId: video!,
                                flags: const YoutubePlayerFlags(
                                  autoPlay: false,
                                )
                            ),
                            showVideoProgressIndicator: true,
                          )
                        )
                      ],
                    )
                  ],
                );
                // return ChildScrollView(
                //   child: Row(
                //     children: [
                //       Column(
                //           children: [
                //             Container(
                //               alignment: Alignment.center,
                //               padding: EdgeInsets.all(10),
                //               height: 250,
                //               child: Image.network(
                //                   "https://image.tmdb.org/t/p/w500/${snapshot.data!.poster}"),
                //             )
                //           ],
                //       ),
                //
                //     ],
                //   ),
                  // child: Column(
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.center,
                  //       padding: EdgeInsets.all(10),
                  //       height: 400,
                  //       child: Image.network(
                  //           "https://image.tmdb.org/t/p/w500/${snapshot.data!.poster}"),
                  //     ),
                  //     Text(
                  //       snapshot.data!.title,
                  //       style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     Text(
                  //       "${snapshot.data!.overview}",
                  //       style: const TextStyle(fontSize: 20, fontFamily: 'Lato'),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     ElevatedButton(
                  //       child: const Text("Reviews", style: TextStyle(fontSize: 18)),
                  //       onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReviewList(movieName: snapshot.data!.title, movieID: snapshot.data!.id!))),
                  //     ),
                  //   ],
                  // ),
              }
            }));
  }
}
