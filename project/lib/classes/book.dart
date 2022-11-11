import 'package:project/views/books_view.dart';

import '';
class Book {
  int? id;
  String? title;
  String? author;
  int? rating;

  Book({
    this.id,
    required this.title,
    required this.author,
    this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      rating: json['rating'],
    );
  }

  Book.fromMap(Map map){
    this.id = map['id'];
    this.title = map['title'];
    this.author = map['author'];
    this.rating = map['rating'];
  }

  String toString(){
    return 'BooksView[id: $id], title: $title, author: $author, rating: $rating';
  }
  Map<String, Object?> toMap(){
    return{
      'id': this.id,
      'title': this.title,
      'author': this.author,
      'rating': this.rating,

    };
  }
}

