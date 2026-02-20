import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_mobx_and_rxdart/core/remote/movie_api.dart';
import 'package:movie_app_mobx_and_rxdart/models/api_response.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

@lazySingleton
class MovieRepository {
  MovieRepository(this.api);

  final MovieApi api;

  Future<Either<Exception, ApiResponse<MovieResponse>>> getPopular({
    int page = 1,
  }) async {
    try {
      final response = await api.getPopular(page: page);

      debugPrint('DATA : ${response.results}');

      return right(response);
    } on DioException catch (e) {
      return left(e);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<Either<Exception, ApiResponse<MovieResponse>>> search({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await api.search(query: query, page: page);

      debugPrint('DATA search : ${response.results}');

      return right(response);
    } on DioException catch (e) {
      return left(e);
    } on Exception catch (e) {
      return left(e);
    }
  }
}