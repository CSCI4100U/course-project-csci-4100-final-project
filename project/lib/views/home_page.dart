import 'package:flutter/material.dart';
import '../views/trending_movies_view.dart';
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
  Widget build(BuildContext context) {
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
  }

}
