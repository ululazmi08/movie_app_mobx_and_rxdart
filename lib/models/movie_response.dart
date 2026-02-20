import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_response.freezed.dart';
part 'movie_response.g.dart';

@freezed
class MovieResponse with _$MovieResponse {
  const factory MovieResponse({
    required bool adult,
    String? backdropPath,
    required int id,
    String? originalTitle,
    required String overview,
    required double popularity,
    String? posterPath,
    String? releaseDate,
    required String title,
    required bool video,
    double? voteAverage,
    int? voteCount,
  }) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
}
