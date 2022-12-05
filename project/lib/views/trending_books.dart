import 'package:flutter/material.dart';
import 'package:project/views/home_view.dart';

import '../components/drawer.dart';
import 'chart_page.dart';

class TrendingBooks extends StatefulWidget {
  const TrendingBooks({Key? key}) : super(key: key);

  @override
  State<TrendingBooks> createState() => _TrendingBooksState();
}

class _TrendingBooksState extends State<TrendingBooks> {
  String _value = "book";
  @override
  Widget build(BuildContext context) {
    int? selectedMovieID;
    String? selectedMovieName;
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: ThemeData.dark(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _value,
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'movie',
                  child: Text('Trending Movies'),
                ),
                DropdownMenuItem(
                  value: 'book',
                  child: Text('Trending Books'),
                )
              ],
              onChanged: (String? value) {
                setState(() {
                  _value = value!;
                  if(_value == "movie"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                HomeView(),
                        ));
                  }
                });
              },
            ),
          ),
        ),
        // title: Text(FlutterI18n.translate(context, "Home.Trending")),
        actions: [
          IconButton(
            icon: const Icon(Icons.insert_chart),
            onPressed: () {
              // if (_trending.isNotEmpty) {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (_) => ChartPage(trending: _trending)));
              // }
            },
          )
        ],
      ),
      drawer: const NavDrawer(),
      body: Center(
        // child: FutureBuilder<List<Trending<Movie>>>(
        //   future: Fetch.fetchTrendingMovies(),
        //   builder: (context, snapshot) {
        //     if (snapshot.data == null) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       _trending = snapshot.data!;
        //       return ListView.builder(
        //           addAutomaticKeepAlives: false,
        //           addRepaintBoundaries: false,
        //           itemCount: snapshot.data?.length,
        //           itemBuilder: (context, index){
        //             return GestureDetector(
        //               onTap: () {
        //                 selectedMovieID = snapshot.data![index].base.id;
        //                 selectedMovieName = snapshot.data![index].base.title;
        //                 ScaffoldMessenger.of(context).showSnackBar(
        //                     SnackBar(
        //                         duration: const Duration(seconds: 1),
        //                         content: Text('Getting Movie Info for $selectedMovieName')
        //                     ));
        //                 Future.delayed(
        //                     const Duration(seconds: 2),
        //                         () async {
        //                       await Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(movieID: selectedMovieID, movieName: selectedMovieName,)));
        //                     }
        //                 );
        //               },
        //               child: MovieTile(movie: snapshot.data![index].base, rating: snapshot.data![index].rating),
        //             );
        //           });
        //     }},
        // ),
      ),
    );
  }
}
