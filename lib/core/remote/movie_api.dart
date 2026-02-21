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
  Future<ApiResponse<MovieResponse>> getPopular({
    @Query('page') int page = 1,
    @Query('language') required String language,
  });

  @GET(UrlPath.nowPlaying)
  Future<ApiResponse<MovieResponse>> getNowPlaying({
    @Query('page') int page = 1,
    @Query('language') required String language,
  });

  @GET(UrlPath.upcoming)
  Future<ApiResponse<MovieResponse>> getUpcoming({
    @Query('page') int page = 1,
    @Query('language') required String language,
  });

  @GET(UrlPath.search)
  Future<ApiResponse<MovieResponse>> search({
    @Query('query') required String query,
    @Query('page') int page = 1,
    @Query('language') required String language,

  });
}