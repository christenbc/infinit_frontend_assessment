import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinit_frontend_assessment/models/models.dart';
import 'package:path_provider/path_provider.dart';

class TMDBAPI {
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie';

  static const _headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NDRmMzFjYmI5YjI1MGQ2M2E4YmZmNGY3MzA1Zjc5YiIsIm5iZiI6MTcyNTM4MjE2OS4yNjEwODksInN1YiI6IjY2ZDczZDVhMGVjYzE3MzJhMGY3MTcyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UpqmR974U4g6SqNBZOi6n98GrxVMTXzsrG7S0NiMYbY',
    'accept': 'application/json'
  };

  static late Dio _dio;

  static Future<void> init() async {
    late HiveCacheStore cacheStore;
    if (kIsWeb) {
      await Hive.initFlutter();
      cacheStore = HiveCacheStore(null);
    } else {
      final appDocDir = await getApplicationDocumentsDirectory();
      cacheStore = HiveCacheStore(appDocDir.path);
    }

    final options = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
    );

    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: _headers,
    ))
      ..interceptors.add(DioCacheInterceptor(options: options));
  }

  /// Retrieves a batch of top rated movies listed by the API
  static Future<TopRatedResponse> fetchTopRatedMovies({required int page}) async {
    String url = '$_baseUrl/top_rated?language=en-US&page=$page';

    final response = await _dio.get(url);

    final dynamic rawData = response.data;
    if (response.statusCode == 200 || response.statusCode == 304) {
      // 200 OK or 304 Not Modified
      return TopRatedResponse.fromJson(rawData);
    } else {
      final dynamic message = rawData["message"];
      throw Exception(message);
    }
  }
}
