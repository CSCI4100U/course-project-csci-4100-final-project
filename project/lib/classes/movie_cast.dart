class MovieCast {
  final String name;
  final String profile;
  final String character;
  final num popularity;

  MovieCast({
    required this.name,
    required this.profile,
    required this.character,
    required this.popularity,
  });

  factory MovieCast.fromMap(Map map){
    return MovieCast(
      name: map['name'],
      profile: map['profile_path'],
      character: map['character'],
      popularity: map['popularity'],
    );
  }

  Map<String, Object> toMap() {
    return <String, Object>{
      'name': name,
      'profile_path': profile,
      'character': character,
      'popularity': popularity,
    };
  }

  String toString(){
    return name.toString();
  }
}

