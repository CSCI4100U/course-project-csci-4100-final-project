import '';
class Movie {
  final String release;
  final String poster;
  final String title;

  const Movie({
    required this.release,
    required this.poster,
    required this.title,
  });

  factory Movie.fromMap(Map map){
    return Movie(
      poster: map['poster_path'],
      release: map['release_date'],
      title: map['title'],
    );
  }

  String toString(){
    return release.toString();
  }
}

