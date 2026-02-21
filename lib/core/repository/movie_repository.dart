import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_mobx_and_rxdart/core/enum/enum.dart';
import 'package:movie_app_mobx_and_rxdart/core/remote/movie_api.dart';
import 'package:movie_app_mobx_and_rxdart/models/api_response.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';
import 'package:movie_app_mobx_and_rxdart/stores/locale_store.dart';

@lazySingleton
class MovieRepository {
  MovieRepository(this.api, this.localeStore);

  final MovieApi api;
  final LocaleStore localeStore;

  String get _languageCode => localeStore.isEnglish ? 'en-US' : 'id-ID';

  Future<Either<Exception, ApiResponse<MovieResponse>>> getMovies({
    required MovieCategory category,
    int page = 1,
  }) async {
    try {
      late ApiResponse<MovieResponse> response;
      switch (category) {
        case MovieCategory.popular:
          response = await api.getPopular(page: page, language: _languageCode);
          break;
        case MovieCategory.nowPlaying:
          response = await api.getNowPlaying(page: page, language: _languageCode);
          break;
        case MovieCategory.upcoming:
          response = await api.getUpcoming(page: page, language: _languageCode);
          break;
      }

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
      final response = await api.search(
        query: query,
        page: page,
        language: _languageCode,
      );
      return right(response);
    } on DioException catch (e) {
      return left(e);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
