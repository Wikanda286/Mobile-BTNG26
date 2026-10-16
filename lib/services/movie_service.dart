import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/core/constants/api_constants.dart';
import 'package:movieapp/models/movie.dart';

class MovieService {
  final Dio _dio;

  MovieService(this._dio);

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio.get(ApiConstants.movies);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['data'] is List) {
          final List listData = data['data'];
          return listData
              .map((item) => Movie.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } on DioException catch (e) {
      debugPrint("Dio error saat getMovies: ${e.message}");
      throw _handleDioError(e);
    } catch (e) {
      debugPrint("Error umum saat getMovies: $e");
      throw Exception("Gagal memuat film: Terjadi kesalahan sistem.");
    }
  }

  Future<Movie> getMovieDetail(int id) async {
    try {
      final response = await _dio.get(ApiConstants.movieDetail(id));

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic> && data['data'] != null) {
          return Movie.fromJson(data['data'] as Map<String, dynamic>);
        }
      }
      throw Exception("Data film dengan ID $id tidak ditemukan.");
    } on DioException catch (e) {
      debugPrint("Dio error saat getMovieDetail: ${e.message}");
      throw _handleDioError(e);
    } catch (e) {
      debugPrint("Error umum saat getMovieDetail: $e");
      throw Exception("Gagal memuat detail film.");
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception("Koneksi internet lambat / time out. Silakan coba lagi.");
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return Exception("Server mengalami kendala (Kode error: $statusCode).");
      case DioExceptionType.connectionError:
        return Exception("Tidak dapat terhubung ke internet. Periksa koneksi Anda.");
      default:
        return Exception("Terjadi gangguan jaringan: ${error.message ?? 'Coba lagi nanti.'}");
    }
  }
}
