import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/core/network/dio_client.dart';
import 'package:movieapp/services/movie_service.dart';
import 'package:movieapp/services/watchlist_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => DioClient.createDio());
  getIt.registerLazySingleton<MovieService>(() => MovieService(getIt<Dio>()));
  getIt.registerLazySingleton<WatchlistService>(() => WatchlistService());
}
