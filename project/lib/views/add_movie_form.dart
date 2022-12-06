import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
        backgroundColor: Colors.purple,
        title: Text(FlutterI18n.translate(context, "Add_mov.Add_movT")),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: FlutterI18n.translate(context, "Add_mov.Mov_T"),
                hintText: FlutterI18n.translate(context, "Add_mov.Hint"),
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: FlutterI18n.translate(context, "Add_mov.Release"),
                hintText: "2022-11-04",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _release = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: FlutterI18n.translate(context, "Add_mov.URL"),
                hintText: "/tegBpjM5ODoYoM1NjaiHVLEA0QM.jpg",
              ),
              validator: _notEmptyValidator,
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
            // Movie movie = Movie(title: _title, release: _release, poster: _poster);
            // Navigator.of(context).pop(movie);
          }
        },
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