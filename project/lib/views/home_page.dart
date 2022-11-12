import 'package:flutter/material.dart';
import 'movies_view.dart';
import 'books_view.dart';
import '../views/home_view.dart';
import 'addBook.dart';

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
                showAboutDialog(
                  context: context,
                  applicationName: "Final Project",
                  applicationVersion: "0.1",
                  applicationIcon: const Icon(Icons.movie),
                  applicationLegalese: "Group members:\nAlexander Giannoulis\nSejal Shingal\nEbubechukwu Okeke\nDavid Dickson\nBence Takacs",
                );
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            MoviesView(),
            addBook(),
          ],

        ),


      ),
    );
  }
}

void _showAboutDialog() {

}