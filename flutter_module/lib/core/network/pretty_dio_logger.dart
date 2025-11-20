/// Created by Aabhash Shakya on 19/11/2025
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PrettyDioLogger extends Interceptor {
  final bool printResponseBody;
  final bool printRequestBody;

  PrettyDioLogger({this.printResponseBody = true, this.printRequestBody = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final headers = Map<String, dynamic>.from(options.headers);

    debugPrint('══════════ Request ══════════');
    debugPrint('METHOD: ${options.method}');
    debugPrint('URL: ${options.uri}');
    debugPrint('HEADERS: $headers');

    if (printRequestBody && options.data != null) {
      try {
        final jsonBody = _tryFormatJson(options.data);
        debugPrint('BODY: $jsonBody');
      } catch (_) {
        debugPrint('BODY: ${options.data}');
      }
    }

    debugPrint('══════════════════════════════');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('══════════ Response ═════════');
    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('URL: ${response.requestOptions.uri}');

    if (printResponseBody && response.data != null) {
      try {
        final jsonBody = _tryFormatJson(response.data);
        debugPrint('DATA: $jsonBody');
      } catch (_) {
        debugPrint('DATA: ${response.data}');
      }
    }

    debugPrint('══════════════════════════════');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('══════════ Error ═══════════=');
    debugPrint('STATUS: ${err.response?.statusCode}');
    debugPrint('URL: ${err.requestOptions.uri}');
    debugPrint('MESSAGE: ${err.message}');
    if (err.response?.data != null) {
      try {
        final jsonBody = _tryFormatJson(err.response!.data);
        debugPrint('DATA: $jsonBody');
      } catch (_) {
        debugPrint('DATA: ${err.response?.data}');
      }
    }
    debugPrint('══════════════════════════════');
    handler.next(err);
  }

  String _tryFormatJson(dynamic data) {
    if (data is String) return const JsonEncoder.withIndent('  ').convert(jsonDecode(data));
    return const JsonEncoder.withIndent('  ').convert(data);
  }
}

