import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  int? id;
  final String imdbId;
  final String release;
  final String poster;
  final String title;
  int? budget;
  String? overview;

  int? runtime;
  String? status;
  String? tagline;
  bool? video;
  DocumentReference? reference;

  Movie({
    this.id,
    required this.imdbId,
    required this.release,
    required this.poster,
    required this.title,
    this.budget,
    this.overview,
    this.runtime,
    this.status,
    this.tagline,
    this.video,
  });

  factory Movie.fromMap(Map map){
    return Movie(
      id: map['id'],
      imdbId: map['imdb_id'],
      poster: map['poster_path'],
      release: map['release_date'],
      title: map['title'],
      budget:  map['budget'],
      overview: map['overview'],
      runtime: map['runtime'],
      status: map['status'],
      tagline: map['tagline'],
      video: map['video'],
    );
  }

  Map<String, Object> toMap() {
    return <String, Object>{
      'imdb_id': imdbId,
      'poster_path': poster,
      'release_date': release,
      'title': title,
    };
  }

  @override
  String toString(){
    return title.toString();
  }
}

