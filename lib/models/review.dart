class Review {
  final int id;
  final String author;
  final String avatarUrl;
  final double rating;
  final String content;
  final String createdAt;

  Review({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.content,
    required this.createdAt,
  });
}
