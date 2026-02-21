import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app_mobx_and_rxdart/core/enum/enum.dart';
import 'package:movie_app_mobx_and_rxdart/core/l10n/l10n.dart';
import 'package:movie_app_mobx_and_rxdart/core/routes.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/locale_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/theme_store.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/movie_card.dart';
import 'package:movie_app_mobx_and_rxdart/widgets/shimmer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.homeStore,
    required this.bookmarkStore,
    required this.themeStore,
    required this.localeStore,
  });

  final ThemeStore themeStore;
  final HomeStore homeStore;
  final BookmarkStore bookmarkStore;
  final LocaleStore localeStore;

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
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: Text(
                widget.localeStore.isEnglish ? '🇬🇧' : '🇮🇩',
                textScaler: TextScaler.noScaling,
                style: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                widget.localeStore.toggleLocale();
                widget.homeStore.load();
              },
              tooltip: widget.localeStore.isEnglish ? 'English' : 'Bahasa Indonesia',
            ),
          ),
          Observer(
            builder: (_) {
              final brightness = MediaQuery.of(context).platformBrightness;
              final bool isActuallyDark = widget.themeStore.themeMode == ThemeMode.system
                  ? brightness == Brightness.dark
                  : widget.themeStore.themeMode == ThemeMode.dark;

              return IconButton(
                icon: Icon(
                  isActuallyDark ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: (){
                  widget.themeStore.toggleTheme(brightness);
                },
              );
            }
          ),
        ],
        title: Text(
          context.l10n.movies,
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
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.l10n.find,
                                textScaler: TextScaler.noScaling,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Icon(Icons.search_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Observer(
                      builder: (_) {
                        final selectedCategory = widget.homeStore.selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            MovieCategory tempSelected = selectedCategory;
                            showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setStateSheet) {
                                    return SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 7),
                                          Stack(
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                                  child: Text(
                                                    'Filter',
                                                    textAlign: TextAlign.center,
                                                    textScaler: TextScaler.noScaling,
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 15,
                                                top: -3,
                                                child: GestureDetector(
                                                  onTap: () => context.pop(),
                                                  child: const Icon(Icons.close_rounded),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.symmetric(horizontal: 17),
                                            itemCount: MovieCategory.values.length,
                                            itemBuilder: (context, index) {
                                              final category = MovieCategory.values[index];
                                              final isSelected = tempSelected == category;

                                              return GestureDetector(
                                                onTap: () {
                                                  setStateSheet(() => tempSelected = category);
                                                },
                                                child: ColoredBox(
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 8,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          category.label(context.l10n),
                                                          textScaler: TextScaler.noScaling,
                                                          style: Theme.of(context).textTheme.bodySmall,
                                                        ),
                                                        if (isSelected)
                                                          const Icon(
                                                            Icons.check_box_rounded,
                                                            color: Colors.deepPurple,
                                                          )
                                                        else
                                                          const Icon(
                                                            Icons.check_box_outline_blank_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (_, __) => const Divider(
                                              thickness: 1,
                                              color: Colors.grey,
                                              height: 0,
                                            ),
                                          ),
                                          Container(height: 4, color: Colors.grey),
                                          GestureDetector(
                                            onTap: () {
                                              widget.homeStore.changeCategory(tempSelected);
                                              context.pop();
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(
                                                vertical: 20,
                                                horizontal: 30,
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Colors.deepPurple,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    context.l10n.apply,
                                                    textAlign: TextAlign.center,
                                                    textScaler: TextScaler.noScaling,
                                                    style: Theme.of(context).textTheme.bodySmall
                                                        ?.copyWith(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 45,
                            width: 90,
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.filter_list),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    selectedCategory.label(context.l10n),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textScaler: TextScaler.noScaling,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Observer(
                  builder: (_) => Text(
                    widget.homeStore.selectedCategory.label(context.l10n),
                    textScaler: TextScaler.noScaling,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
                                Text(
                                  widget.homeStore.errorMessage!,
                                  textScaler: TextScaler.noScaling,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: widget.homeStore.load,
                                  child: Text('Coba Lagi',
                                    textScaler: TextScaler.noScaling,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
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
