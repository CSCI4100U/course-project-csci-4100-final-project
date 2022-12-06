import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/views/auth/login_page.dart';
import 'package:project/views/trending_movies_view.dart';
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
    // final text = MediaQuery.of(context).platformBrightness == Brightness.dark
    //   ?'DarkTheme'
    //     :'Lightheme';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text((FlutterI18n.translate(context, "Account.Title"))),
      ),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                  (FlutterI18n.translate(context, "Account.Acc_header")),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.underline,
                  )
              ),
            ),
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
                      (FlutterI18n.translate(context, "Account.Name")),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25,0,0),
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
                      (FlutterI18n.translate(context, "Account.Email")),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                  (FlutterI18n.translate(context, "Account.Pref_header")),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.underline,
                  )
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    (FlutterI18n.translate(context, "Account.Dark_mode")),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                ChangeThemeButtonWidget(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Text(
                  (FlutterI18n.translate(context, "Account.Lang_pick")),
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    Locale newLocale = Locale('en');
                    setState(() {
                      FlutterI18n.refresh(context, newLocale);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => TrendingMovies()));
                    });
                  },
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/thumbnails/001/416/623/small/canada-isolated-flag-vector.jpg',
                    height: 75,
                    width: 75,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Locale newLocale = Locale('fr');
                    setState(() {
                      FlutterI18n.refresh(context, newLocale);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => TrendingMovies()));
                    });
                  },
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/00/10/13/60/360_F_10136081_MY1gsMpkrvLTjKQJcIGqWeZ75gnN0EqD.jpg',
                    height: 75,
                    width: 75,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Locale newLocale = Locale('es');
                    setState(() {
                      FlutterI18n.refresh(context, newLocale);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => TrendingMovies()));
                    });
                  },
                  child: Image.network(
                    'https://media.istockphoto.com/id/176621296/vector/flag-of-spain-icon-with-no-background.jpg?s=612x612&w=0&k=20&c=u5EEUpfx7Bvd-j9c_LcasZqRJII9A9GZhyHPAW4IBA4=',
                    height: 75,
                    width: 75,
                  ),
                )
              ],
            )
          ]
      ),
    );

  }

}

