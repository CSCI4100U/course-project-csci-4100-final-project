import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  BookTile({Key? key, required this.book}) : super(key: key);
  TextStyle style = const TextStyle(fontFamily: "Lato");
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.cover == null ? const Icon(Icons.question_mark) : Image.network("https://covers.openlibrary.org/b/id/${book.cover}.jpg"),
      title: Text(book.title, style: style,),
      subtitle: Text("Publish Date: ${book.publishDate ?? "Unknown"}", style: style,),
    );
  }
}
