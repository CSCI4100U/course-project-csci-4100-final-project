import 'package:flutter/material.dart';
import 'movieView.dart';
import 'booksView.dart';
import '../views/homeView.dart';
import 'addBookForm.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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