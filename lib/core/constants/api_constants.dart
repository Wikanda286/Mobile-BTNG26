class ApiConstants {
  static const String baseUrl = 'https://api-mobile.dnccudinus.org';
  static const String movies = '/api/movies';
  static const String movieGenres = '/api/movies/genres';

  static String movieDetail(int id) => '/api/movies/$id';
}
