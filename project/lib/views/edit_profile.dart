import 'package:flutter/material.dart';
import '../components/drawer.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late String _title;
    late String _release;
    late String _poster;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Your Profile"),
      ),
      drawer: NavDrawer(),
      body: Container(),
    );
  }
}
