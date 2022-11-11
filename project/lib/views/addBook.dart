import 'package:flutter/material.dart';
import'../../classes/book.dart';
import 'package:project/models/book_model.dart';
class addBook extends StatefulWidget {
  const addBook({Key? key}) : super(key: key);

  @override
  State<addBook> createState() => _addBookState();
}

class _addBookState extends State<addBook> {
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
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Book Title',
              ),
              onChanged: (value){
                titleVal = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Author',
              ),
              onChanged: (value){
                authorVal = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Personal rating',
              ),
              onChanged: (value){
                ratingVal = int.tryParse(value);
              },
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            Book insert = Book(title: titleVal, author: authorVal);
            if(ratingVal != null)
            {
              insert.rating = ratingVal;
            }
            idVal = await _model.insertBook(insert);
            showSnackBarBook(context);
            List<Book> currDB = await _model.getAllBooks();
            for (Book todo in currDB){
              print(todo);
            }
            print("Current items: $currDB");
            print("Book inserted: $idVal,${insert.toString()}");
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
