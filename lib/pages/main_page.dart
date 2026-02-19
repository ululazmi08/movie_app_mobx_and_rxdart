import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/pages/bookmark_page.dart';
import 'package:movie_app_mobx_and_rxdart/pages/home_page.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/navigation_store.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final navigationStore = NavigationStore();
  final bookmarkStore = BookmarkStore();
  final homeStore = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        body: IndexedStack(
          index: navigationStore.currentIndex,
          children: [
            HomePage(store: homeStore, bookmarkStore: bookmarkStore),
            BookmarkPage(store: bookmarkStore),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationStore.currentIndex,
          onTap: navigationStore.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "Bookmark",
            ),
          ],
        ),
      ),
    );
  }
}
