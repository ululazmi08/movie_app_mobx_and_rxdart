import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key, required this.store});

  final BookmarkStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        itemCount: store.bookmarks.length,
        itemBuilder: (_, index) {
          final item = store.bookmarks[index];
          return ListTile(
            title: Text(item.title),
          );
        },
      ),
    );
  }
}
