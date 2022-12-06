import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/views/trending_movies_view.dart';
import '../components/drawer.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late String _name;
    late String _photoUrl;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text((FlutterI18n.translate(context, "Update.Title"))),
      ),
      drawer: NavDrawer(),
      body:Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: (FlutterI18n.translate(context, "Update.Input_n")),
                hintText: "John Doe",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: (FlutterI18n.translate(context, "Update.Input_p")),
                hintText: "https://profilepic.com/user.jpg",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _photoUrl = value!;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async{
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            await user?.updateDisplayName(_name);
            await user?.updatePhotoURL(_photoUrl);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
  String? _notEmptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return (FlutterI18n.translate(context, "Rev_form.Enter"));
    }
    return null;
  }
}
