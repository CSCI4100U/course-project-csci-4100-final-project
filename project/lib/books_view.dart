import 'package:flutter/material.dart';
import 'main.dart';
class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [

            Text("Books Search"),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Book Title',
                )
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Year Published',
                )
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Author',
                )
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Publisher',
                )
            )
          ]
      ),
    );
  }
}
