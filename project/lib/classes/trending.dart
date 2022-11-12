import 'package:cloud_firestore/cloud_firestore.dart';

class Trending {
  int? id;
  final String release;
  final String poster;
  final String title;
  final num? rating;
  DocumentReference? reference;

  Trending({
    this.id,
    required this.release,
    required this.poster,
    required this.title,
    this.rating,
  });

  factory Trending.fromMap(Map map){
    return Trending(
      id: map['id'],
      poster: map['poster_path'],
      release: map['release_date'],
      title: map['title'],
      rating: map['vote_average'],
    );
  }

  Map<String, Object> toMap() {
    return <String, Object>{
      'poster_path': poster,
      'release_date': release,
      'title': title,
    };
  }

  String toString(){
    return release.toString();
  }
}