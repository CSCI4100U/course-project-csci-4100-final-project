import 'package:flutter/material.dart';

import '../components/theme_button.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);
  @override
  State<AccountView> createState() => _AccountViewState();

}

class _AccountViewState extends State<AccountView>{
  var numPosts;

  @override
  void initState(){

  }
  @override
  Widget build(BuildContext context){
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
      ?'DarkTheme'
        :'Lightheme';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Page"),
        actions: [
          ChangeThemeButtonWidget(),
        ]

      ),
      body: Column(
        children: const [
          Text(
              "Your email is: ",
              textAlign: TextAlign.center
          ),
          Text(
              "Your password is: ",
              textAlign: TextAlign.center,
          ),
        ]
      ),
    );

  }

}

