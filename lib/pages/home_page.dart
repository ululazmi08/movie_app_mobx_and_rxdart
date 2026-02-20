import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_mobx_and_rxdart/core/routes.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/theme_store.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/movie_card.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/shimmer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.homeStore,
    required this.bookmarkStore,
    required this.themeStore,
  });

  final ThemeStore themeStore;
  final HomeStore homeStore;
  final BookmarkStore bookmarkStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.homeStore.load();
    });

    // ✅ Trigger loadMore saat scroll mendekati bawah
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 200) {
        widget.homeStore.loadMore();
      }
    });
  }

  @override
  void dispose() {
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
        // elevation: 2,
        // shadowColor: Colors.black.withAlpha(25),
        actions: [
          Observer(
            builder: (_) {
              final brightness = MediaQuery.of(context).platformBrightness;
              final bool isActuallyDark = widget.themeStore.themeMode == ThemeMode.system
                  ? brightness == Brightness.dark
                  : widget.themeStore.themeMode == ThemeMode.dark;

              return IconButton(
                icon: Icon(
                  isActuallyDark ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: (){
                  widget.themeStore.toggleTheme(brightness);
                },
              );
            }
          ),
        ],
        title: Text(
          'Movies',
          textScaler: TextScaler.noScaling,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          context.push(RoutePath.search.path);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            Icon(Icons.search_rounded)
                          ],),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 5),
                          Icon(Icons.filter_list),
                          const SizedBox(width: 5),
                          Text(
                            'Popular',
                            textScaler: TextScaler.noScaling,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Popular',
                  textScaler: TextScaler.noScaling,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.homeStore.load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  children: [
                    Observer(
                      builder: (_) {
                        if (widget.homeStore.isLoading) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            itemBuilder: (context, index){
                              return ShimmerWidget(
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                circular: 6,
                              );
                            },
                            separatorBuilder: (_,__)=> SizedBox(height: 8),
                            itemCount: 5,
                          );
                        }

                        if (widget.homeStore.errorMessage != null &&
                            widget.homeStore.movies.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.homeStore.errorMessage!),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: widget.homeStore.load,
                                  child: const Text('Coba Lagi'),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          itemCount: widget.homeStore.movies.length + (widget.homeStore.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == widget.homeStore.movies.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }

                            final movie = widget.homeStore.movies[index];
                            return Observer(
                              builder: (_) {
                                final isBookmarked = widget.bookmarkStore.isBookmarked(movie.id);
                                return MovieCard(
                                  movie: movie,
                                  onTap: () => widget.bookmarkStore.toggleBookmark(movie),
                                  isBookmarked: isBookmarked,
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
