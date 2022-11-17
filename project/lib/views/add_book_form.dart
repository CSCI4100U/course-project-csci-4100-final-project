import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';

class addBook extends StatefulWidget {
  const addBook({Key? key}) : super(key: key);

  @override
  State<addBook> createState() => _addBookState();
}

class _addBookState extends State<addBook> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late int? _rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Book"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Book Title",
                hintText: "The Dragon",
              ),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Author Name",
                hintText: "John Doe",
              ),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (value) {
                _author = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Rating",
                hintText: "9",
              ),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (value) {
                _rating = int.tryParse(value!);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Book book = Book(title: _title, author: _author, rating: _rating);
            Navigator.of(context).pop(book);
          }
        },
      ),
    );
  }
}
