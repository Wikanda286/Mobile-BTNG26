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
