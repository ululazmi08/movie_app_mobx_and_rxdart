import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_mobx_and_rxdart/core/env/env.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final _dio = Dio();

  Dio getDioClient({
    required String baseUrl,
  }) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
    );

    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${Env.accessToken}';
    _dio.options.headers['Accept'] = 'application/json';

    _dio.interceptors.addAll([
      if (kDebugMode)
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: false,
          maxWidth: 1000,
        ),
    ]);

    return _dio;
  }
}
