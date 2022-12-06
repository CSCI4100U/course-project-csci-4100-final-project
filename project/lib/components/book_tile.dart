import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.cover == null ? const Icon(Icons.error) : Image.network("https://covers.openlibrary.org/b/id/${book.cover}.jpg"),
      title: Text(book.author != "Unknown Author" ? "${book.title} by ${book.author}" : book.title),
      subtitle: Text("Publish Date: ${book.publishDate}"),
    );
  }
}
