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
            ),


          ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          showSnackBarBook(context),
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
