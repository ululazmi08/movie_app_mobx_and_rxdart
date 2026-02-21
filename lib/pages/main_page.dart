import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/core/injection/injection.dart';
import 'package:movie_app_mobx_and_rxdart/core/l10n/l10n.dart';
import 'package:movie_app_mobx_and_rxdart/pages/bookmark_page.dart';
import 'package:movie_app_mobx_and_rxdart/pages/home_page.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/locale_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/navigation_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/theme_store.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key, required this.themeStore, required this.bookmarkStore, required this.localeStore});

  final ThemeStore themeStore;
  final BookmarkStore bookmarkStore;
  final LocaleStore localeStore;
  final navigationStore = NavigationStore();
  final homeStore = getIt<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        body: IndexedStack(
          index: navigationStore.currentIndex,
          children: [
            HomePage(
              themeStore: themeStore,
              homeStore: homeStore,
              bookmarkStore: bookmarkStore,
              localeStore: localeStore,
            ),
            BookmarkPage(store: bookmarkStore),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationStore.currentIndex,
          onTap: navigationStore.changeTab,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: context.l10n.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: context.l10n.bookmark,
            ),
          ],
        ),
      ),
    );
  }
}
