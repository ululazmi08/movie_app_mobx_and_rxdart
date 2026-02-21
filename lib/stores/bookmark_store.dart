import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

part 'bookmark_store.g.dart';

class BookmarkStore = _BookmarkStore with _$BookmarkStore;

abstract class _BookmarkStore with Store {
  @observable
  ObservableList<MovieResponse> bookmarks = ObservableList<MovieResponse>();

  @observable
  bool isAscending = true;

  @action
  void toggleBookmark(MovieResponse movie) {
    final exists = bookmarks.any((e) => e.id == movie.id);
    if (exists) {
      bookmarks.removeWhere((e) => e.id == movie.id);
    } else {
      bookmarks.add(movie);
    }
    _saveToStorage();
  }

  @action
  void toggleSort() {
    isAscending = !isAscending;
    if (isAscending) {
      bookmarks.sort((a, b) => a.title.compareTo(b.title));
    } else {
      bookmarks.sort((a, b) => b.title.compareTo(a.title));
    }
    _saveToStorage();
  }

  @action
  void loadBookmarks() {
    final String? data = localStorage.getItem('bookmarks');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      bookmarks.clear();
      bookmarks.addAll(
        jsonList.map((e) => MovieResponse.fromJson(e)).toList(),
      );
    }
  }

  void _saveToStorage() {
    final String data = jsonEncode(bookmarks.map((e) => e.toJson()).toList());
    localStorage.setItem('bookmarks', data);
  }

  @computed
  Set<int> get bookmarkedIds => bookmarks.map((e) => e.id).toSet();

  bool isBookmarked(int movieId) => bookmarkedIds.contains(movieId);
}