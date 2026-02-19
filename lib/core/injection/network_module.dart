import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_mobx_and_rxdart/core/connection/dio_client.dart';
import 'package:movie_app_mobx_and_rxdart/core/env/env.dart';
import 'package:movie_app_mobx_and_rxdart/core/remote/movie_api.dart';

@module
abstract class NetworkModule {
  Dio getDio() {
    final dioClient = DioClient();

    return dioClient.getDioClient(
      baseUrl: Env.baseUrl,
    );
  }

  @lazySingleton
  MovieApi movieApi(Dio dio) => MovieApi(dio);
}