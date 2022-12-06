import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';
import 'package:project/models/book_model.dart';
import 'package:project/models/fetch_data.dart';
import 'package:project/classes/book_author.dart';
import 'package:project/views/books_view.dart';
import'package:project/classes/notification_manager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key, required this.id, required this.title}) : super(key: key);
  final String id;
  final String title;
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Book? currentBook;
  final BookModel _model = BookModel();
  @override
  final _notifications = Notifications();

  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    _notifications.init();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: _addToDB,
              icon: Icon(Icons.playlist_add)
          ),
        ],
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
                    ),
                    const SizedBox(
                      height: 50,
                      child: Text(
                        "Book Authors",
                        style: TextStyle(fontSize: 30,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    FutureBuilder<List<BookAuthor>>(
                      future: Fetch.fetchBookAuthors(currentBook!),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 50,
                                shadowColor: Colors.black,
                                child: SizedBox(
                                  width: 200,
                                  height: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          child: Image.network("https://static.thenounproject.com/attribution/4289718-600.png")
                                        ),
                                        const Padding(padding: EdgeInsets.all(10)),
                                        SizedBox(
                                          width: 140,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Author Name: ${snapshot
                                                    .data![index].name}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  void _addToDB() async{
    if(currentBook != null){
      _notifications.sendNotificationNow("A New Book Has Been Added to your List","Check it out!","");
      await _model.insertBook(currentBook!);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
              const BooksView()
          ));
    }
    else {
      const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Error Adding to Firebase')
      );
    }
  }
}
