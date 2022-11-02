class Movie {
  late final String imdbId;

  Movie({required this.imdbId});

  Movie.fromMap(Map<String, Object?> map) {
    imdbId = map["imdbId"] as String;
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      "imdbId": imdbId,
    };
  }
}