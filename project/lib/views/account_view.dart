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
          backgroundColor: Colors.purple,
        title: const Text("Account Page"),
        actions: [
          ChangeThemeButtonWidget(),
        ]

      ),
      body: Column(
        children: [
          Row(
            children: const [
              Text(
                  "Your email is: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20
                  )
              ),
              Text(
                  "Val 4 now",
                  style: TextStyle(
                    fontSize: 20
                  )
              )
            ],
          ),
          Text(
              "Your password is: ",
              textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20
            )
          ),
        ]
      ),
    );

  }

}

