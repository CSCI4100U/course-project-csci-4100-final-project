import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/components/book_tile.dart';
import 'package:project/views/book_details.dart';
import '../classes/book.dart';
import '../components/drawer.dart';
import '../models/book_search_delegate.dart';
import '../models/book_model.dart';

class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);
  @override
  State<BooksView> createState() => _BooksViewState();

}

class _BooksViewState extends State<BooksView> {
  final _model = BookModel();
  List<Book> books = [];
  String? selectedBookId;
  String? selectedBookTitle;
  TextStyle style = const TextStyle(fontFamily: "Lato");

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedBookName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(FlutterI18n.translate(context, "Book_tab.Book_list"), style: style,),
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
      drawer: NavDrawer(),
      body: FutureBuilder<List<Book>>(
                  future: _model.getAllBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // Error
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 50.0),
                          Text(FlutterI18n.translate(context, "Mov_tab.Con_fail"), style: style,),
                        ],
                      );
                    } else if (!snapshot.hasData) {
                      // Loading
                      return const CircularProgressIndicator();
                    } else {
                      // Movie list
                      return ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                selectedBookId = snapshot.data![index].id;
                                selectedBookName = snapshot.data![index].title;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text('Getting Book Info for $selectedBookName', style: style,)
                                    ));
                                Future.delayed(
                                    const Duration(seconds: 2),
                                        () async {
                                      await Navigator.push(context, MaterialPageRoute(builder: (_) => BookDetails(id: selectedBookId!, title: selectedBookName!,)));
                                    }
                                );
                              },
                              child: BookTile(book: snapshot.data![index]),
                            );
                          }
                      );
                    }
                  },
                )
    );

  }
}

