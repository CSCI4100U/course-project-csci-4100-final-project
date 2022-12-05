import 'package:flutter/material.dart';
import 'movie_view.dart';
import 'books_view.dart';
import '../views/trending_movies.dart';
import 'add_book_form.dart';
import'package:project/classes/notification_manager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../components/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/views/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final _notifications = Notifications();

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    _notifications.init();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Scaffold(
            drawer: NavDrawer(),
            body: TrendingMovies(),
          );
        } else {
          return const LoginPage();
        }
      }
    );
    /*return const Scaffold(
        drawer: NavDrawer(),
        body: HomeView(title: 'Trending Movies',),
      );*/
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
