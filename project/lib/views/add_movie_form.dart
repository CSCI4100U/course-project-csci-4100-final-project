import 'package:flutter/material.dart';
import 'package:project/classes/movie.dart';

class AddMovieForm extends StatefulWidget {
  const AddMovieForm({Key? key}) : super(key: key);

  @override
  State<AddMovieForm> createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _release;
  late String _poster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Movie Title",
                hintText: "tt14641788",
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
                labelText: "Release Date",
                hintText: "2022-11-04",
              ),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (value) {
                _release = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Poster URL",
                hintText: "/tegBpjM5ODoYoM1NjaiHVLEA0QM.jpg",
              ),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
              onSaved: (value) {
                _poster = value!;
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
            Movie movie = Movie(title: _title, release: _release, poster: _poster);
            Navigator.of(context).pop(movie);
          }
        },
      ),
    );
  }
}
