// import 'package:flutter/material.dart';
// import '../classes/book.dart';
// import 'addBook.dart';
// import '../models/book_model.dart';
//
//
// class BooksView extends StatefulWidget {
//   const BooksView({Key? key}) : super(key: key);
//   @override
//   State<BooksView> createState() => _BooksViewState();
//
// }
//
// class _BooksViewState extends State<BooksView> {
//   var _model = BookModel();
//   List<Book> books = [];
//
//   @override
//   void initstate(){
//     super.initState();
//     _getData();
//   }
//
//   @override Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           FutureBuilder(
//             future: _getData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 // Error
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.error, color: Colors.red, size: 50.0),
//                     Text(
//                         "Failed to connect to local storage. Please try again later.")
//                   ],
//                 );
//               } else if (!snapshot.hasData) {
//                 // Loading
//                 return const CircularProgressIndicator();
//               } else {
//                 // Movie list
//                 return ListView.builder(
//                     itemCount: snapshot.data?.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index].title),
//                         subtitle: Text("Author: ${snapshot.data![index].author} Rating: ${snapshot.data![index].rating}"),
//                       );
//                     }
//                 );
//               }
//             },
//           ),
//           ElevatedButton(
//               onPressed: () async{
//                 var result = await Navigator.push(context,
//                 MaterialPageRoute(builder: (context)=> const addBook()));
//                 if(result == true){
//                   setState((){
//                     _getData();
//                   });
//                 }
//               },
//               child: Icon(Icons.add)
//           )
//         ],
//       ),
//     );
//   }
//   _getData(){
//     return _model.getAllBooks();
//   }
// }