import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/views/account_view.dart';
import 'package:project/views/books_view.dart';
import 'package:project/views/edit_profile.dart';
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
                        Padding(padding: EdgeInsets.all(10)),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  userName,
                                  style: TextStyle(fontSize: 20, fontFamily: "Lato",color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user!.email!,
                                  style: TextStyle(fontSize: 15, fontFamily: "Lato",color: Colors.white),
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                      // child: UserAccountsDrawerHeader(
                      //   accountName: Text(
                      //     userName,
                      //     style: TextStyle(fontSize: 18),
                      //   ),
                      //   accountEmail: Text(user!.email!),
                      //   currentAccountPictureSize: Size.square(50),
                      //   currentAccountPicture: Image.network(userPhoto),
                      //   ),
                      ),
                  ),
              ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(FlutterI18n.translate(context, "Drawer.Home"), style: TextStyle(),),
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
              leading: Icon(Icons.list_alt),
              title: Text(FlutterI18n.translate(context, "Drawer.My_list")),
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
              leading: Icon(Icons.book),
              title: Text(FlutterI18n.translate(context, "Drawer.Books")),
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
              title: Text(FlutterI18n.translate(context, "Drawer.Find_loc")),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mapView()),
                  );
                });
              },
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white,),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(FlutterI18n.translate(context, "Drawer.Licenses")),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: const Text('Notif Button'),
              onTap: _notificationNow

            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white,),
            ListTile(
              leading: Icon(Icons.person_outline_rounded),
              title: Text("Edit Profile"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
                });
              }
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(FlutterI18n.translate(context, "Drawer.Logout")),
              onTap: _logout,
            )
          ],
        ),
      ),

    );
  }
  void _notificationNow() async {
    _notifications.sendNotificationNow("Movie", "Book", "Book");
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





