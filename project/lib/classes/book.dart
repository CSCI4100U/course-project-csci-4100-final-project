import 'package:project/views/books_view.dart';

import '';
class Book{
  String id;
  String title;
  String key;
  int? cover;
  String? publishDate;
  String? description;
  List<String>? authors;

  Book({
    required this.id,
    required this.title,
    required this.key,
    required this.cover,
    this.publishDate,
    this.description,
  });

  /*Book.fromMap(Map map) {
    id = map['id'];
    title = map['title'];
    cover = map['cover'];
    author = map['author'];
    publishYear = map['publish_year'];
  }*/

  factory Book.fromMap(String id, Map map) {
    String? description;
    if (map['description'] != null) {
      if (map['description'] is String) {
        description = map['description'];
      } else {
        description = map['description']['value'];
      }
    }
    return Book(
      id: id,
      title: map['title'] ?? 'Unknown Title',
      cover: map['covers'] == null ? null : map['covers'][0],
      key: map['key'] ?? 'Unknown',
      publishDate: map['first_publish_date'],
      description: description,
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
      'publish_date': publishDate,
      'key': key,
      'description': description,
    };
  }
}


