import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final _regexEmail = RegExp('^.+@.+\..+\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Email')),
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }
                if (!_regexEmail.hasMatch(value)) {
                  return 'Invalid email format.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              }
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Password')),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password.';
                }
                if (value.length < 10) {
                  return 'Password must have at least 10 characters.';
                }

                return null;
              },
              onSaved: (value) {
                _password = value;
              },
              onChanged: (value) {
                _password = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Confirm Password')),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password.';
                }
                if (value != _password) {
                  return 'Password does not match.';
                }
                return null;
              },
              onSaved: (value) {

              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open),
              label: const Text('Register'),
              onPressed: _register,
            )
          ],
        ),
      ),
    );
  }

  Future _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserCredential? cred;
      try {
        cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email!.trim(), password: _password!.trim());
      } on FirebaseAuthException catch (e) {
        String msg = 'An error occurred.';
        if (e.code == 'invalid-email') {
          msg = 'Invalid email.';
        } else if (e.code == 'email-already-in-use') {
          msg = 'Email already in use.';
        } else if (e.code == 'weak-password') {
          msg = 'Password is not strong enough.';
        }
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Error'),
            content: Text(msg),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        return;
      }
      Navigator.of(context).pop();
    }
  }
}
