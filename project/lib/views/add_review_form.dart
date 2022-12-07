import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
  int rating = 3;
  TextStyle style = const TextStyle(fontFamily: "Lato");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(FlutterI18n.translate(context, "Rev_form.Add_rev"), style: style,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Review movie = Review(movieID: widget.id, title: _title, author: _author, content: _content, rating: rating);
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
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: FlutterI18n.translate(context, "Rev_form.Name"),
                hintText: FlutterI18n.translate(context, "Rev_form.Name"),
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _author = value!;
              },
              style: style,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: FlutterI18n.translate(context, "Rev_form.Title"),
                hintText: FlutterI18n.translate(context, "Rev_form.Titile"),
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _title = value!;
              },
              style: style,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: FlutterI18n.translate(context, "Rev_form.Rev_line"),
                hintText: FlutterI18n.translate(context, "Rev_form.Rev_line"),
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _content = value!;
              },
              style: style,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.star, color: rating >= 1 ? Colors.amber : Colors.grey),
                  onPressed: () => setState(() => rating = 1),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: rating >= 2 ? Colors.amber : Colors.grey),
                  onPressed: () => setState(() => rating = 2),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: rating >= 3 ? Colors.amber : Colors.grey),
                  onPressed: () => setState(() => rating = 3),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: rating >= 4 ? Colors.amber : Colors.grey),
                  onPressed: () => setState(() => rating = 4),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: rating >= 5 ? Colors.amber : Colors.grey),
                  onPressed: () => setState(() => rating = 5),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }

  String? _notEmptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return FlutterI18n.translate(context, "Rev_form.Enter");
    }
    return null;
  }
}
