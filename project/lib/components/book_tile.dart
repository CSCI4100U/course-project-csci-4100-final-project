import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.cover == null ? const Icon(Icons.question_mark) : Image.network("https://covers.openlibrary.org/b/id/${book.cover}.jpg"),
      title: Text(book.title),
      subtitle: Text("Publish Date: ${book.publishDate ?? "Unknown"}"),
    );
  }
}
