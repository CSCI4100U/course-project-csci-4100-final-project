import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  int movieID;
  String author;
  String title;
  int rating;
  String content;
  DocumentReference? reference;

  Review({required this.movieID, required this.author, required this.title, required this.rating, required this.content});

  factory Review.fromMap(Map map) {
    return Review(
      movieID: map['movie_id'],
      author: map['author'],
      title: map['title'],
      rating: map['rating'],
      content: map['content'],
    );
  }

  Map<String, Object> toMap() {
    return <String, Object> {
      'movie_id': movieID,
      'author': author,
      'title': title,
      'rating': rating,
      'content': content,
    };
  }
}