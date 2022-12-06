import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/views/auth/login_page.dart';
import '../components/theme_button.dart';
import 'package:project/components/drawer.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);
  @override
  State<AccountView> createState() => _AccountViewState();

}

class _AccountViewState extends State<AccountView>{
  var user = FirebaseAuth.instance.currentUser;
  var numPosts;
  String userPhoto = "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-27.jpg";
  String userName = "John Doe";

  @override
  void initState(){
    super.initState();
    if (user!.displayName != null){
      userName = user!.displayName!;
    }
    if (user!.photoURL != null){
      userPhoto = user!.photoURL!;
    }
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(userPhoto),
              backgroundColor: Colors.transparent,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                child: Text(
                    "Your name is: ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 20
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30,0,0),
                child: Text(
                    userName,
                    style: TextStyle(
                      fontSize: 20
                    )
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text(
                    "Your email is: ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Text(
                    user!.email!,
                    style: TextStyle(
                        fontSize: 20
                    )
                ),
              )
            ],
          ),
        ]
      ),
    );

  }

}

