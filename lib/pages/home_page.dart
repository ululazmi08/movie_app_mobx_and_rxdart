import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.store,
    required this.bookmarkStore,
  });
  final HomeStore store;
  final BookmarkStore bookmarkStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        itemCount: store.items.length + 1,
        itemBuilder: (context, index) {
          if (index == store.items.length) {
            store.loadNextPage();
            return Center(child: CircularProgressIndicator());
          }

          final item = store.items[index];

          return ListTile(
            title: Text(item.title),
            trailing: Observer(
              builder: (_) {
                final isBookmarked =
                bookmarkStore.bookmarks.any((e) => e.id == item.id);

                return IconButton(
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                  onPressed: () => bookmarkStore.toggleBookmark(item),
                );
              },
            ),

          );
        },
      ),
    );
  }
}
