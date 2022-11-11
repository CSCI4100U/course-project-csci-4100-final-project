import 'package:flutter/material.dart';
import'../../classes/book.dart';
import 'package:project/models/book_model.dart';
class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  var _model = BookModel();
  var idVal;
  var titleVal;
  var authorVal;
  var ratingVal;
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
                ),
              onChanged: (value){
                  titleVal = value;
              },
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Author',
                ),
              onChanged: (value){
                  authorVal = value;
                  },
            ),
            TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Personal rating',
                ),
              onChanged: (value){
                  ratingVal = value;
              },
            ),



          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          Book insert = Book(title: titleVal, author: authorVal, rating: ratingVal);
          idVal = await _model.insertBook(insert);
          showSnackBarBook(context);
        },
        child: const Icon(Icons.search)
      ),
    );
  }
  void showSnackBarBook(BuildContext context){
    var snackBar = SnackBar(
      content: Text("Searching for book..."),
      action: SnackBarAction(
        label: "OK",
        onPressed:() {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
