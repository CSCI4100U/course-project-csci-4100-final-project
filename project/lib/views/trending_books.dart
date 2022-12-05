import 'package:flutter/material.dart';
import 'package:project/classes/trending_book.dart';
import 'package:project/views/trending_movies.dart';
import '../components/drawer.dart';
import '../models/fetch_data.dart';

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
                              TrendingMovies(),
                        ));
                  }
                });
              },
            ),
          ),
        ),
        // title: Text(FlutterI18n.translate(context, "Home.Trending")),
      ),
      drawer: const NavDrawer(),
      body: Center(
        child: FutureBuilder<List<TrendingBook>>(
          future: Fetch.fetchTrendingBooks(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Image.network("https://covers.openlibrary.org/b/id/${snapshot.data![index].cover}.jpg"),
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].author),
                    );
                    // return GestureDetector(
                    //   onTap: () {
                    //     selectedMovieID = snapshot.data![index];
                    //     selectedMovieName = snapshot.data![index];
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //             duration: const Duration(seconds: 1),
                    //             content: Text('Getting Movie Info for $selectedMovieName')
                    //         ));
                    //     Future.delayed(
                    //         const Duration(seconds: 2),
                    //         //     () async {
                    //         //   await Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetails(movieID: selectedMovieID, movieName: selectedMovieName,)));
                    //         // }
                    //     );
                    //   },
                    //   child:
                    // );
                  });
            }},
        ),
      ),
    );
  }
}
