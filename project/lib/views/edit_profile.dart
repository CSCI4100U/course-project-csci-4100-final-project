import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        title: Text("Update Your Profile"),
      ),
      drawer: NavDrawer(),
      body:Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter Your Full Name",
                hintText: "John Doe",
              ),
              validator: _notEmptyValidator,
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter a Photo Url",
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
      return "Please Enter a Value";
    }
    return null;
  }
}
