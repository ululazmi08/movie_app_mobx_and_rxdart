class UrlPath {
  static const movie = 'movie';
  static const search = 'search/$movie';
  static const upcoming = '$movie/upcoming';
  static const nowPlaying = '$movie/now_playing';
  static const popular = '$movie/popular';
  static const detail = '$movie/{id}';
}