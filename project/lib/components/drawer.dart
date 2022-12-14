import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/views/account_view.dart';
import 'package:project/views/books_view.dart';
import 'package:project/views/map_view.dart';
import '../views/trending_movies_view.dart';
import '../views/movie_view.dart';
import'package:project/classes/notification_manager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_auth/firebase_auth.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final _notifications = Notifications();
  var user = FirebaseAuth.instance.currentUser;
  String userName = "John Doe";
  String userPhoto = "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-27.jpg";
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
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    _notifications.init();
    return Drawer(
      child: Container(
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountView()),
                    );
                  });
                },
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                  ), 
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(userPhoto),
                              backgroundColor: Colors.transparent,
                            ),
                          ]
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  userName,
                                  style: const TextStyle(fontSize: 20, fontFamily: "Lato",color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user!.email!,
                                  style: const TextStyle(fontSize: 15, fontFamily: "Lato",color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(FlutterI18n.translate(context, "Drawer.Home"), style: style,),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrendingMovies()),
                  );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.local_movies),
              title: Text(FlutterI18n.translate(context, "Drawer.My_list"), style: style,),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MoviesView()),
                  );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark_outlined),
              title: Text(FlutterI18n.translate(context, "Drawer.Books"), style: style,),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BooksView()),
                  );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.not_listed_location),
              title: Text(FlutterI18n.translate(context, "Drawer.Find_loc"), style: style,),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapCinema()),
                  );
                });
              },
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white,),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(FlutterI18n.translate(context, "Drawer.Licenses"), style: style,),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
              },
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white,),
            ListTile(
              leading: Icon(Icons.person_outline_rounded),
              title: Text((FlutterI18n.translate(context, "Drawer.Edit_prof")),style: style,),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountView()),
                  );
                });
              }
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(FlutterI18n.translate(context, "Drawer.Logout"),style: style,),
              onTap: _logout,
            )
          ],
        ),
      ),

    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
void _showAboutDialog(BuildContext context) {
  showAboutDialog(
    context: context,
    applicationName: "Final Project",
    applicationVersion: "0.1",
    applicationIcon: const Icon(Icons.movie),
    applicationLegalese: "Group members:\nAlexander Giannoulis\nSejal Shingal\nEbubechukwu Okeke\nDavid Dickson\nBence Takacs",
  );
}





