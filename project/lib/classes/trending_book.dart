class TrendingBook{

  final String title;
  final String author;
  final num? cover;
  final String key;
  final num publishYear;


  TrendingBook({
    required this.title,
    required this.author,
    this.cover,
    required this.key,
    required this.publishYear,
  });

  factory TrendingBook.fromMap(Map map){
    return TrendingBook(
      title: map['title'],
      author: map['author_name'][0],
      cover: map['cover_i'],
      key: map['key'],
      publishYear: map["first_publish_year"]
    );
  }

  Map<String, Object> toMap() {
    return <String, Object>{
      'title': title,
      'author_name': author,
      'key': key,
      'first_publish_year': publishYear,
    };
  }
}