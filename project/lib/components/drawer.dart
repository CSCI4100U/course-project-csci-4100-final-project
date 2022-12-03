import 'package:flutter/material.dart';
import 'package:project/views/books_view.dart';
import 'package:project/views/map_view.dart';
import '../views/home_view.dart';
import '../views/movie_view.dart';
import'package:project/classes/notification_manager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_auth/firebase_auth.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final _notifications = Notifications();

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    _notifications.init();
    return Drawer(
      child: Container(
        color: Colors.purple[50],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Container(

                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Home', style: TextStyle(),),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView(title: "Trending")),
                  );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('My List'),
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
              title: const Text('Books'),
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
              title: const Text('Find Locations'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const mapView()),
                  );
                });
              },
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white,),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('Licenses'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: const Text('Notif Button'),
              onTap: () {
                _notificationNow;
              },
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white,),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
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



