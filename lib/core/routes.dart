import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_mobx_and_rxdart/pages/main_page.dart';
import 'package:movie_app_mobx_and_rxdart/pages/search_page.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/theme_store.dart';

enum RoutePath {
  root('/'),
  search('/search');

  final String path;
  const RoutePath(this.path);
}

class AppRouter {
  final ThemeStore themeStore;
  final BookmarkStore bookmarkStore;

  AppRouter({required this.themeStore, required this.bookmarkStore});

  late final GoRouter router = GoRouter(
    initialLocation: RoutePath.root.path,
    routes: [
      GoRoute(
        path: RoutePath.root.path,
        builder: (context, state) => MainPage(
          themeStore: themeStore,
          bookmarkStore: bookmarkStore,
        ),
      ),
      GoRoute(
        path: RoutePath.search.path,
        builder: (context, state) => SearchPage(
          bookmarkStore: bookmarkStore,
        ),
      ),
    ],
  );
}
