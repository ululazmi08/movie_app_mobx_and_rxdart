// lib/pages/search_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/core/injection/injection.dart';
import 'package:movie_app_mobx_and_rxdart/core/l10n/l10n.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/search_store.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/movie_card.dart'; // Asumsi kamu punya ini

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.bookmarkStore});

  final BookmarkStore bookmarkStore;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchStore _searchStore;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchStore = getIt<SearchStore>();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _searchStore.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _searchStore.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(25),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextFormField(
            autofocus: true,
            onChanged: _searchStore.setSearchQuery,
            decoration: InputDecoration(
              hintText: context.l10n.find,
              hintStyle: Theme.of(context).textTheme.titleMedium,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (_searchStore.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_searchStore.errorMessage != null && _searchStore.movies.isEmpty) {
              return Center(
                child: Text(
                  _searchStore.errorMessage!,
                  textScaler: TextScaler.noScaling,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }

            if (_searchStore.movies.isEmpty && _searchStore.isLoading == false) {
              return Center(
                child: Text(context.l10n.searchInfo,
                  textScaler: TextScaler.noScaling,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _searchStore.movies.length + (_searchStore.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _searchStore.movies.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final movie = _searchStore.movies[index];
                return Observer(
                  builder: (_) {
                    final isBookmarked = widget.bookmarkStore.isBookmarked(movie.id);
                    return MovieCard(
                      movie: movie,
                      isBookmarked: isBookmarked,
                      onTap: () =>
                          widget.bookmarkStore.toggleBookmark(movie),
                    );
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          },
        ),
      ),
    );
  }
}
