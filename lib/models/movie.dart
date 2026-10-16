import 'package:movieapp/models/cast.dart';
import 'package:movieapp/models/review.dart';

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final double rating;
  final int releaseYear;
  final int durationMinutes;
  final List<String> genre;
  final String synopsis;
  final List<Cast> cast;
  final List<Review> reviews;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.releaseYear,
    required this.durationMinutes,
    required this.genre,
    required this.synopsis,
    this.cast = const [],
    this.reviews = const [],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> parsedGenre = [];
    if (json['genre'] is List) {
      parsedGenre = (json['genre'] as List)
          .map((item) => item.toString())
          .toList();
    }

    List<Cast> parsedCast = [];
    if (json['cast'] is List) {
      parsedCast = (json['cast'] as List)
          .map((item) => Cast.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    List<Review> parsedReviews = [];
    if (json['reviews'] is List) {
      parsedReviews = (json['reviews'] as List)
          .map((item) => Review.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return Movie(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? '',
      posterUrl: json['posterUrl']?.toString() ?? '',
      backdropUrl: json['backdropUrl']?.toString() ?? '',
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0.0') ?? 0.0,
      releaseYear: json['releaseYear'] is int
          ? json['releaseYear'] as int
          : int.tryParse(json['releaseYear']?.toString() ?? '0') ?? 0,
      durationMinutes: json['durationMinutes'] is int
          ? json['durationMinutes'] as int
          : int.tryParse(json['durationMinutes']?.toString() ?? '0') ?? 0,
      genre: parsedGenre,
      synopsis: json['synopsis']?.toString() ?? '',
      cast: parsedCast,
      reviews: parsedReviews,
    );
  }

  Movie copyWith({
    int? id,
    String? title,
    String? posterUrl,
    String? backdropUrl,
    double? rating,
    int? releaseYear,
    int? durationMinutes,
    List<String>? genre,
    String? synopsis,
    List<Cast>? cast,
    List<Review>? reviews,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      backdropUrl: backdropUrl ?? this.backdropUrl,
      rating: rating ?? this.rating,
      releaseYear: releaseYear ?? this.releaseYear,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      genre: genre ?? this.genre,
      synopsis: synopsis ?? this.synopsis,
      cast: cast ?? this.cast,
      reviews: reviews ?? this.reviews,
    );
  }

  String getFormattedDuration() => "$durationMinutes Minutes";

  String getPrimaryGenre() {
    if (genre.isNotEmpty) {
      return genre.first;
    }
    return 'Action';
  }

  String getSafeSynopsis() {
    if (synopsis.isNotEmpty) {
      return synopsis;
    }
    return "Deskripsi film belum tersedia.";
  }
}
