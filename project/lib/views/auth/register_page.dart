import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
  TextStyle style = const TextStyle(fontFamily: "Lato");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(FlutterI18n.translate(context, "Register.Register"), style: style,),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(label: Text(FlutterI18n.translate(context, "Register.Email"), style: style,)),
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return FlutterI18n.translate(context, "Register.E_null");
                  }
                  if (!_regexEmail.hasMatch(value)) {
                    return FlutterI18n.translate(context, "Register.E_invalid");
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                }
            ),
            TextFormField(
              decoration: InputDecoration(label: Text(FlutterI18n.translate(context, "Register.Password"), style: style,)),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return FlutterI18n.translate(context, "Register.P_null");
                }
                if (value.length < 10) {
                  return FlutterI18n.translate(context, "Register.P_format");
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
              decoration: InputDecoration(label: Text(FlutterI18n.translate(context, "Register.Pass_confirm"), style: style,)),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return FlutterI18n.translate(context, "Register.P_null");
                }
                if (value != _password) {
                  return FlutterI18n.translate(context, "Register.P_match");
                }
                return null;
              },
              onSaved: (value) {

              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open),
              label: Text(FlutterI18n.translate(context, "Register.Register"), style: style,),
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
