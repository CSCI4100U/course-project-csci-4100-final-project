import 'package:flutter/material.dart';
import '../classes/book.dart';
import '../components/drawer.dart';
import 'add_book_form.dart';
import '../models/book_model.dart';
import 'package:project/models/fetch_data.dart';

class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);
  @override
  State<BooksView> createState() => _BooksViewState();

}

class _BooksViewState extends State<BooksView> {
  final _model = BookModel();
  List<Book> books = [];

  @override
  void initState(){
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedBookID;
    String? selectedBookName;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Book List")
      ),
      drawer: NavDrawer(),
      body: Center(
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${books[index].title}"),
                  subtitle: Text(
                      "Author: ${"${books[index].title}"} Rating: ${books[index].description}"),
                );
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          String? id = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddBookForm()));
          if (id == null) {
            return;
          }
          Book book = await Fetch.fetchBookDetails(id);
          _model.insertBook(book);
          setState(() => books.add(book));
        },
      )
    );

  }
  _getData() async{
    books.clear();
    List<Book> result = await _model.getAllBooks();
    setState(() {
      for(Book book in result){
        books.add(book);
      }
    });
  }
}

