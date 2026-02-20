import 'package:mobx/mobx.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

part 'bookmark_store.g.dart';

class BookmarkStore = _BookmarkStore with _$BookmarkStore;

abstract class _BookmarkStore with Store {
  @observable
  ObservableList<MovieResponse> bookmarks = ObservableList<MovieResponse>();

  @action
  void toggleBookmark(MovieResponse movie) {
    final exists = bookmarks.any((e) => e.id == movie.id);

    if (exists) {
      bookmarks.removeWhere((e) => e.id == movie.id);
    } else {
      bookmarks.add(movie);
    }
  }

  @computed
  Set<int> get bookmarkedIds =>
      bookmarks.map((e) => e.id).toSet();
}
