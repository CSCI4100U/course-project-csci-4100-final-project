import '';
class Book {
  final String results;
  final int id;
  final String title;

  const Book({
    required this.results,
    required this.id,
    required this.title,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      results: json['results'],
      id: json['id'],
      title: json['title'],
    );
  }
  //Check this out when uncommented and check the errors about vars
  //fromMap is needed

  // Book.fromMap(Map map){
  //   this.results = map['results'];
  //   this.id = map['id'];
  //   this.title = map['title'];
  // }

  String toString(){
    return results.toString();
  }
  Map<String, Object?> toMap(){
    return{
      'results': this.results,
      'id': this.id,
      'title': this.title,

    };
  }
}

