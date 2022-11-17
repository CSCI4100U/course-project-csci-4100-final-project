import 'package:cloud_firestore/cloud_firestore.dart';

class MovieCast {
  int? id;
  final String release;
  final String poster;
  final String title;
  DocumentReference? reference;

  MovieCast({
    this.id,
    required this.release,
    required this.poster,
    required this.title,
  });

  factory MovieCast.fromMap(Map map){
    return MovieCast(
      id: map['id'],
      poster: map['poster_path'],
      release: map['release_date'],
      title: map['title'],
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

