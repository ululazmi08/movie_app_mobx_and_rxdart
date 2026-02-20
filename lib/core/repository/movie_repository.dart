import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_mobx_and_rxdart/core/remote/movie_api.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

@lazySingleton
class MovieRepository {
  MovieRepository(this.api);

  final MovieApi api;

  Future<Either<Exception, List<MovieResponse>>> getPopular() async {
    try {
      final response = await api.getPopular();

      debugPrint('DATA : ${response.results}');

      if (response.results != null) {
        return right(response.results!);
      } else {
        return left(Exception('data null'));
      }
    } on DioException catch (e) {
      return left(e);
    } on Exception catch (e) {
      return left(e);
    }
  }
}