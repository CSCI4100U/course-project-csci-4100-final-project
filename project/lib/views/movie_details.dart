import 'package:flutter/material.dart';
import '../classes/movie.dart';
import '../classes/movie_cast.dart';
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
        body: Column(
          children: [
            FutureBuilder<Movie>(
                // future uses the widget's future field if it's not null, otherwise the pre-defined Fetch function
                future: Fetch.fetchMovieDetails(widget.movieID),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: ListView(
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
                              const Padding(padding: EdgeInsets.all(5)),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 50,
                                    padding: EdgeInsets.all(5),
                                    child: Image.network(
                                        "https://image.tmdb.org/t/p/w500/${snapshot.data!.poster}"),
                                  )
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              Expanded(
                                flex: 2,
                                child:Column(
                                  children: [
                                    Text(
                                      "'${snapshot.data!.tagline}'",
                                      style: const TextStyle(fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "${snapshot.data!.overview}",
                                      style: const TextStyle(fontSize: 15, fontFamily: 'Lato'),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
                    //               child:
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
                }),
            const SizedBox(
              height: 50,
              child: Text(
                "Movie Cast",
                style: TextStyle(fontSize: 30, fontFamily: 'Lato', fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            FutureBuilder<List<MovieCast>>(
                future: Fetch.fetchMovieCast(widget.movieID),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index){
                              return Card(
                                elevation: 50,
                                shadowColor: Colors.black,
                                child: SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [

                                        SizedBox(
                                          width: 60,
                                          child: Image.network(
                                              "https://image.tmdb.org/t/p/w500/${snapshot.data![index].profile}"),
                                        ),
                                        const Padding(padding: EdgeInsets.all(10)),
                                        SizedBox(
                                          width: 140,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Actor Name: ${snapshot.data![index].name}",
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "Character Played: ${snapshot.data![index].character}",
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Lato'),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "Actor Rating: ${snapshot.data![index].popularity/20}",
                                                style: const TextStyle(fontSize: 15, fontFamily: 'Lato'),
                                                textAlign: TextAlign.left,
                                              )
                                            ],

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                    );
                  }
                })
          ],
        )
    );
  }
}
