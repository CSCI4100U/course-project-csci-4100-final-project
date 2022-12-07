import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../components/drawer.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser;
  TextStyle style = const TextStyle(fontFamily: "Lato");

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    late String name;
    late String photoUrl;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text((FlutterI18n.translate(context, "Update.Title")), style: style,),
      ),
      drawer: const NavDrawer(),
      body:Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: (FlutterI18n.translate(context, "Update.Input_n")),
                hintText: "John Doe",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                name = value!;
              },
              style: style,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: (FlutterI18n.translate(context, "Update.Input_p")),
                hintText: "https://profilepic.com/user.jpg",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                photoUrl = value!;
              },
              style: style,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async{
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            await user?.updateDisplayName(name);
            await user?.updatePhotoURL(photoUrl);
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
