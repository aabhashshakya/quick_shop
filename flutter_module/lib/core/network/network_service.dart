/// Created by Aabhash Shakya on 19/11/2025
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_module/core/network/pretty_dio_logger.dart';
import '../provider/app_config_provider.dart';

const String BASE_URL = 'https://fakestoreapi.com/'; // Example

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  late final Dio _dio;
  AppConfigProvider? _configProvider;

  NetworkService._internal() {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL));

    // Append UUID in headers if available
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final uuid = _configProvider?.config?.uuid;
          if (uuid != null) options.headers['X-UUID'] = uuid;

          handler.next(options);
        },
      ),
    );

    // Log API calls
    _dio.interceptors.add(PrettyDioLogger());
  }

  void attachConfigProvider(AppConfigProvider provider) {
    _configProvider = provider;
    _configProvider?.addListener(() {
      debugPrint(
          'AppConfig changed! NetworkService will now use latest UUID');
    });
  }

  /// GET request with async/await
  Future<T> get<T>(
      String path, {
        Map<String, dynamic>? queryParams,
      }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response.data as T;
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  /// POST request with async/await
  Future<T> post<T>(
      String path, {
        Map<String, dynamic>? body,
        Map<String, dynamic>? queryParams,
      }) async {
    try {
      final response =
      await _dio.post(path, data: body, queryParameters: queryParams);
      return response.data as T;
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }
}
