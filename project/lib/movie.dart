import '';
class Movie {
  final String results;
  final int id;
  final String title;

  const Movie({
    required this.results,
    required this.id,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      results: json['results'],
      id: json['id'],
      title: json['title'],
    );
  }

  String toString(){
    return results.toString();
  }
}

