// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookmarkStore on _BookmarkStore, Store {
  Computed<Set<int>>? _$bookmarkedIdsComputed;

  @override
  Set<int> get bookmarkedIds =>
      (_$bookmarkedIdsComputed ??= Computed<Set<int>>(() => super.bookmarkedIds,
              name: '_BookmarkStore.bookmarkedIds'))
          .value;

  late final _$bookmarksAtom =
      Atom(name: '_BookmarkStore.bookmarks', context: context);

  @override
  ObservableList<MovieResponse> get bookmarks {
    _$bookmarksAtom.reportRead();
    return super.bookmarks;
  }

  @override
  set bookmarks(ObservableList<MovieResponse> value) {
    _$bookmarksAtom.reportWrite(value, super.bookmarks, () {
      super.bookmarks = value;
    });
  }

  late final _$_BookmarkStoreActionController =
      ActionController(name: '_BookmarkStore', context: context);

  @override
  void toggleBookmark(MovieResponse movie) {
    final _$actionInfo = _$_BookmarkStoreActionController.startAction(
        name: '_BookmarkStore.toggleBookmark');
    try {
      return super.toggleBookmark(movie);
    } finally {
      _$_BookmarkStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadBookmarks() {
    final _$actionInfo = _$_BookmarkStoreActionController.startAction(
        name: '_BookmarkStore.loadBookmarks');
    try {
      return super.loadBookmarks();
    } finally {
      _$_BookmarkStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bookmarks: ${bookmarks},
bookmarkedIds: ${bookmarkedIds}
    ''';
  }
}
