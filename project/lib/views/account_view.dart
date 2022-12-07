import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/views/trending_movies_view.dart';
import '../components/theme_button.dart';
import 'package:project/components/drawer.dart';
import 'edit_profile.dart';

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
  TextStyle style = const TextStyle(fontFamily: "Lato");

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text((FlutterI18n.translate(context, "Account.Title")), style: style,),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      drawer: const NavDrawer(),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                  (FlutterI18n.translate(context, "Account.Acc_header")),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.underline,
                    fontFamily: "Lato"
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
                  padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                  child: Text(
                      (FlutterI18n.translate(context, "Account.Name")),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                        fontFamily: "Lato"
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25,0,0),
                  child: Text(
                      userName,
                      style: const TextStyle(
                          fontSize: 15,
                        fontFamily: "Lato"
                      )
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Text(
                      (FlutterI18n.translate(context, "Account.Email")),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                        fontFamily: "Lato"
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                      user!.email!,
                      style: const TextStyle(
                          fontSize: 15,
                        fontFamily: "Lato"
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
                  style: const TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.underline,
                    fontFamily: "Lato"
                  )
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    (FlutterI18n.translate(context, "Account.Dark_mode")),
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Lato"
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
                  style: const TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    fontFamily: "Lato"
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    Locale newLocale = const Locale('en');
                    setState(() {
                      FlutterI18n.refresh(context, newLocale);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TrendingMovies()));
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
                    Locale newLocale = const Locale('fr');
                    setState(() {
                      FlutterI18n.refresh(context, newLocale);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TrendingMovies()));
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
                    Locale newLocale = const Locale('es');
                    setState(() {
                      FlutterI18n.refresh(context, newLocale);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TrendingMovies()));
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

