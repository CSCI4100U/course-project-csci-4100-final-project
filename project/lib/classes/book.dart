import 'package:project/views/books_view.dart';

import '';
class Book{
  String id;
  String title;
  String key;
  num? cover;
  String author;
  String publishDate;

  Book({
    required this.id,
    required this.title,
    required this.key,
    required this.cover,
    required this.author,
    required this.publishDate,
  });

  /*Book.fromMap(Map map) {
    id = map['id'];
    title = map['title'];
    cover = map['cover'];
    author = map['author'];
    publishYear = map['publish_year'];
  }*/

  factory Book.fromMap(String id, Map map) {
    return Book(
      id: id,
      title: map['title'] ?? 'Unknown Title',
      author: 'Unknown Author',
      cover: map['covers'] == null ? null : map['covers'][0],
      key: map['key'] ?? 'Unknown',
      publishDate: map['first_publish_date'] ?? 'Unknown',
    );
  }

  @override
  String toString(){
    return 'Book(id: $id, title: $title';
  }
  Map<String, Object?> toMap(){
    return {
      'id': id,
      'title': title,
      'cover': cover,
      'author': author,
      'publish_date': publishDate,
      'key': key,
    };
  }
}


