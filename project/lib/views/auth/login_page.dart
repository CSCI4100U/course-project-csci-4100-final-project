import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/views/auth/register_page.dart';

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
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                  decoration: const InputDecoration(label: Text('Email')),
                  autocorrect: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  }
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('Password')),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open),
              label: const Text('Sign In'),
              onPressed: _signIn,
            ),
            TextButton(
              onPressed: _register,
              child: const Text('Register Now'),
            )
          ],
        ),
      ),
    );
  }

  Future _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential cred = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: _email!.trim(),
          password: _password!.trim(),
        );
      } on FirebaseAuthException catch (e) {
        String msg = 'An error occurred.';
        if (e.code == 'invalid-email') {
          msg = 'Invalid email.';
        } else if (e.code == 'user-disabled') {
          msg = 'Account disabled.';
        } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          msg = 'Incorrect username and password combination.';
        }
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Error'),
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
    }
  }

  Future _register() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterPage()));
  }
}
