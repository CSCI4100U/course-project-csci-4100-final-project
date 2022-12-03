import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("Email")),
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
              },
              onSaved: (value) {
                _email = value;
              }
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text("Password")),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open),
              label: const Text("Sign In"),
              onPressed: _signIn,
            )
          ],
        ),
      ),
    );
  }

  Future _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email!.trim(),
        password: _password!.trim(),
      );
    }
  }
}
