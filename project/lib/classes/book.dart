import 'package:project/views/books_view.dart';

import '';
class Book<B>{
  // int? id;
  String? description;
  String? title;
  // String? author;
  // int? rating;

  Book({
    // this.id,
    required this.title,
    required this.description,
    // required this.author,
    // this.rating,
  });

  // factory Book.fromJson(Map<String, dynamic> json) {
  //   return Book(
  //     id: json['id'],
  //     title: json['title'],
  //     author: json['author'],
  //     rating: json['rating'],
  //   );
  // }

  Book.fromMap(Map map){
    // this.id = map['id'];
    this.description = map['description'];
    this.title = map['title'];
    // this.author = map['author'];
    // this.rating = map['rating'];
  }

  String toString(){
    //return 'BooksView[id: $id], title: $title, author: $author, rating: $rating';
    return 'BooksView[description: $description, title: $title';
  }
  Map<String, Object?> toMap(){
    return{
      // 'id': this.id,
      'title': this.title,
      'description':this.description,
      // 'author': this.author,
      // 'rating': this.rating,

    };
  }
}


