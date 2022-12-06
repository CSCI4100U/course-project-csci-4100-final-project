import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';
import 'package:project/models/fetch_data.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key, required this.id, required this.title}) : super(key: key);
  final String id;
  final String title;
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Book? currentBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          FutureBuilder<Book>(
            future: Fetch.fetchBookDetails(widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              currentBook = snapshot.data;
              return Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.fromLTRB(
                            5, 40, 10, 10)),
                        Flexible(
                          child:
                          Text(
                            snapshot.data!.title,
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lato',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.fromLTRB(
                            5, 0, 10, 10)),
                        Text(
                          " ${snapshot.data!.publishDate ?? "Unknown Publish Date"} ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                            flex: 1,
                            child: Container(
                              width: 50,
                              padding: EdgeInsets.all(5),
                              child: Image.network(
                                "https://covers.openlibrary.org/b/id/${snapshot.data!.cover}.jpg"
                              ),
                            )
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.description ?? "No Description.",
                                style: const TextStyle(
                                    fontSize: 15, fontFamily: 'Lato'),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
