import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/views/auth/register_page.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  final TextStyle style = const TextStyle(fontFamily: "Lato");
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
          backgroundColor: Colors.purple,
          title: Text(FlutterI18n.translate(context, "Login.Title"), style: widget.style),
          actions: [
            Container(
              padding: const EdgeInsets.fromLTRB(50, 20, 0, 20),
              child: Text(FlutterI18n.translate(context, "Login.Lang_mod"), style: widget.style,),
            ),
            PopupMenuButton(
                itemBuilder: (context){
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text("EN", style: widget.style,),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Text("ES", style: widget.style,),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Text("FR", style: widget.style,),
                    ),
                  ];
                },

                onSelected: (value) async {
                  if (value == 0) {
                    Locale newLocale = Locale('en');
                    await FlutterI18n.refresh(context, newLocale);
                    setState(() {

                    });
                  } else if (value == 1) {
                    Locale newLocale = Locale('es');
                    await FlutterI18n.refresh(context, newLocale);
                    setState(() {

                    });
                  } else if (value == 2) {
                    Locale newLocale = Locale('fr');
                    await FlutterI18n.refresh(context, newLocale);
                    setState(() {

                    });
                  }
                }
            ),

          ]
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(label: Text(FlutterI18n.translate(context, "Login.Email"), style: widget.style,)),
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return FlutterI18n.translate(context, "Login.E_null");
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                }
            ),
            TextFormField(
              decoration: InputDecoration(label: Text(FlutterI18n.translate(context, "Login.Password"), style: widget.style,)),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return FlutterI18n.translate(context, "Login.P_null");
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            ElevatedButton.icon(

                icon: const Icon(Icons.lock_open),
                label: Text(FlutterI18n.translate(context, "Login.Sign_in"), style: widget.style,),
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                )
            ),
            TextButton(
              style: TextButton.styleFrom(
              ),
              onPressed: _register,
              child: Text(
                  style: const TextStyle(color: Colors.purple, fontFamily: "Lato"),
                  FlutterI18n.translate(context, "Login.Register")
              ),
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
            title: Text('Login Error', style: widget.style,),
            content: Text(msg, style: widget.style,),
            actions: [
              TextButton(
                child: Text('OK', style: widget.style,),
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