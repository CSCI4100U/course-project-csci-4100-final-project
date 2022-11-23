import 'package:flutter/material.dart';
import 'package:project/classes/review.dart';

class AddReviewForm extends StatefulWidget {
  // Movie title
  final String title;
  // Movie ID
  final int id;

  const AddReviewForm({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  State<AddReviewForm> createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>();
  late String _author;
  late String _title;
  late String _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add review: ${widget.title}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Review movie = Review(movieID: widget.id, title: _title, author: _author, content: _content, rating: 0);
            Navigator.of(context).pop(movie);
          }
        },
        child: const Icon(Icons.save),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Your Name",
                hintText: "Your Name",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _author = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Title",
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
                labelText: "Review",
                hintText: "Review",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _content = value!;
              },
            ),
          ],
        ),
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
