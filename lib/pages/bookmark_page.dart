import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/movie_card.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key, required this.store});

  final BookmarkStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(25),
        title: Text(
          'Bookmark',
          textScaler: TextScaler.noScaling,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Observer(
              builder: (_) => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: store.bookmarks.length,
                itemBuilder: (_, index) {
                  final item = store.bookmarks[index];
                  final isBookmarked = store.isBookmarked(item.id);
                  return MovieCard(
                    movie: item,
                    onTap: () => store.toggleBookmark(item),
                    isBookmarked: isBookmarked,
                  );
                },
                separatorBuilder: (_, i) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
