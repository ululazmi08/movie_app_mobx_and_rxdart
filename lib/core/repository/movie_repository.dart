import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app_mobx_and_rxdart/core/remote/movie_api.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

@lazySingleton
class MemberRepository {
  MemberRepository(this.api);

  final MovieApi api;


  Future<Either<Exception, List<MovieResponse>>> getMemberTier() async {
    try {

      final response = await api.getPopular();

      if(response.results != null) {
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