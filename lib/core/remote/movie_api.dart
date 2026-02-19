import 'package:dio/dio.dart';
import 'package:movie_app_mobx_and_rxdart/core/constant/url_path_const.dart';
import 'package:movie_app_mobx_and_rxdart/models/api_response.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_api.g.dart';

@RestApi()
abstract class MovieApi {
  factory MovieApi(Dio dio) = _MovieApi;

  @GET(UrlPath.popular)
  Future<ApiResponse<MovieResponse>> getPopular();
}