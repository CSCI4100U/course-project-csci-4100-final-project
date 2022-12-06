import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';

class AddBookForm extends StatefulWidget {
  const AddBookForm({Key? key}) : super(key: key);

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  String? _title;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Add Book"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Book ID",
                hintText: "OpenLibrary identifier",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _id = value!;
              },
            ),
            /*TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Book Title",
                hintText: "Title",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Book Description",
                hintText: "Description",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _description = value!;
              },
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            //Book book = Book(id: _id!, title: _title!, description: _description!);
            Navigator.of(context).pop(_id);
          }
        },
      ),
    );
  }

  String? _notEmptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return "Please enter a value";
    }
    return null;
  }
}
