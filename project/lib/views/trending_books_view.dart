import 'package:flutter/material.dart';
import 'package:project/classes/trending_book.dart';
import 'package:project/views/trending_movies_view.dart';
import '../components/drawer.dart';
import '../models/fetch_data.dart';
import 'book_details.dart';

class TrendingBooks extends StatefulWidget {
  const TrendingBooks({Key? key}) : super(key: key);

  @override
  State<TrendingBooks> createState() => _TrendingBooksState();
}

class _TrendingBooksState extends State<TrendingBooks> {
  String _value = "book";

  @override
  Widget build(BuildContext context) {
    String? selectedBookID;
    String? selectedBookName;
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
                    return GestureDetector(
                      onTap: () {
                        selectedBookID = snapshot.data![index].key;
                        var parts = selectedBookID?.split('/');
                        print(parts![2]);
                        selectedBookName = snapshot.data![index].title;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text('Getting Book Info for $selectedBookName')
                            ));
                        Future.delayed(
                            const Duration(seconds: 2),
                                () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          BookDetails(id: parts[2], title: selectedBookName!,),
                                  ));
                            }
                        );
                      },
                      child: ListTile(
                        leading: Image.network("https://covers.openlibrary.org/b/id/${snapshot.data![index].cover}.jpg"),
                        title: Text("${snapshot.data![index].title} by ${snapshot.data![index].author}"),
                        subtitle: Text("Published in: ${snapshot.data![index].publishYear}"),
                      )
                    );
                  });
            }},
        ),
      ),
    );
  }
}
