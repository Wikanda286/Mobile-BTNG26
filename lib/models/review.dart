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

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      author: json['author']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? '',
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0.0') ?? 0.0,
      content: json['content']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
