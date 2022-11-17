class Review {
  String author;
  String title;
  int rating;
  String content;

  Review({required this.author, required this.title, required this.rating, required this.content});

  factory Review.fromMap(Map map) {
    return Review(
      author: map['author'],
      title: map['title'],
      rating: map['rating'],
      content: map['content'],
    );
  }

  Map<String, Object> toMap() {
    return <String, Object> {
      'author': author,
      'title': title,
      'rating': rating,
      'content': content,
    };
  }
}