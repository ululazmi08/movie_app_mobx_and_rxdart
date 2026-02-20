import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.homeStore,
    required this.bookmarkStore,
  });

  final HomeStore homeStore;
  final BookmarkStore bookmarkStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.homeStore.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Popular Movies")),
      body: Observer(
        builder: (_) {
          if (widget.homeStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.homeStore.errorMessage != null) {
            return Center(
              child: Text(widget.homeStore.errorMessage!),
            );
          }

          // return SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       ListView.builder(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemCount: widget.homeStore.movies.length,
          //         itemBuilder: (context, index) {
          //           final movie = widget.homeStore.movies[index];
          //
          //           return Column(
          //             children: [
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: Column(
          //                       children: [
          //                         Text(movie.overview),
          //                       ],
          //                     ),
          //                   ),
          //                   Observer(
          //                     builder: (_) {
          //                       final isBookmarked =
          //                       widget.bookmarkStore.bookmarkedIds
          //                           .contains(movie.id);
          //
          //                       return IconButton(
          //                         icon: Icon(
          //                           isBookmarked
          //                               ? Icons.bookmark
          //                               : Icons.bookmark_border,
          //                         ),
          //                         onPressed: () =>
          //                             widget.bookmarkStore.toggleBookmark(movie),
          //                       );
          //                     },
          //                   ),
          //                 ],
          //               )
          //             ],
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // );
          return Text("Movies: ${widget.homeStore.movies.length}");

        },
      ),
    );
  }
}
