import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/classes/book.dart';
import 'package:project/views/trending_movies_view.dart';
import '../components/drawer.dart';
import '../models/fetch_data.dart';
import 'book_details.dart';
import 'package:project/components/book_tile.dart';
import 'package:project/models/book_search_delegate.dart';

class TrendingBooks extends StatefulWidget {
  const TrendingBooks({Key? key}) : super(key: key);

  @override
  State<TrendingBooks> createState() => _TrendingBooksState();
}

class _TrendingBooksState extends State<TrendingBooks> {
  String _value = "book";
  TextStyle style = const TextStyle(fontFamily: "Lato");

  @override
  Widget build(BuildContext context) {
    String? selectedBookID;
    String? selectedBookName;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
        title: Theme(
          data: ThemeData.dark(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _value,
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'movie',
                  child: Text((FlutterI18n.translate(context, "Home.Trending")), style: style,),
                ),
                DropdownMenuItem(
                  value: 'book',
                  child: Text((FlutterI18n.translate(context, "Home.TrendingB")), style: style,),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              var book = await showSearch(
                context: context,
                delegate: BookSearchDelegate(),
              );
              if (book != null) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                    BookDetails(id: book.id, title: book.title)));
              }
            },
          ),
        ]
      ),
      drawer: const NavDrawer(),
      body: Center(
        child: FutureBuilder<List<Book>>(
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
                                content: Text('Getting Book Info for $selectedBookName', style: style,)
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
                      child: BookTile(book: snapshot.data![index]),
                    );
                  });
            }},
        ),
      ),
    );
  }
}
