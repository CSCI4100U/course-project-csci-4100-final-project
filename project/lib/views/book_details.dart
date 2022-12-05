import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key, required this.id, required this.title}) : super(key: key);
  final String id;
  final String title;
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
