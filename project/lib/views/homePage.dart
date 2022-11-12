import 'package:flutter/material.dart';
import 'movieView.dart';
import 'booksView.dart';
import '../views/homeView.dart';
import 'addBookForm.dart';
import'package:project/classes/notification_manager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final _notifications = Notifications();

  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    _notifications.init();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Final Project"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.movie)),
              Tab(icon: Icon(Icons.book)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                _showAboutDialog(context);
              },
            ),
            IconButton(
              onPressed: _notificationNow,
              icon: Icon(Icons.notifications),
            )
          ],
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            MoviesView(),
            BooksView(),
          ],

        ),


      ),
    );
  }

  void _notificationNow() async {
    _notifications.sendNotificationNow("Movie", "Book", "Book");
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
