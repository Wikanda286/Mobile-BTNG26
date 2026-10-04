class Genre {
  final String slug;
  final String nama;
  final int jumlah;

  Genre({
    required this.slug,
    required this.nama,
    required this.jumlah,
  });
}

class Cast {
  final int id;
  final String name;
  final String character;
  final String avatarUrl;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.avatarUrl,
  });
}

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
