import 'package:project/views/books_view.dart';

import '';
class Book{
  // int? id;
  late String id;
  late String description;
  late String title;
  // String? author;
  // int? rating;

  Book({
    // this.id,
    required this.id,
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
    id = map['id'];
    description = map['description'];
    title = map['title'];
    // this.author = map['author'];
    // this.rating = map['rating'];
  }

  @override
  String toString(){
    //return 'BooksView[id: $id], title: $title, author: $author, rating: $rating';
    return 'Book(id: $id, description: $description, title: $title';
  }
  Map<String, Object?> toMap(){
    return {
      'id': id,
      'title': title,
      'description':description,
      // 'author': this.author,
      // 'rating': this.rating,
    };
  }
}


