import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localstorage/localstorage.dart';
import 'package:movie_app_mobx_and_rxdart/core/injection/injection.dart';
import 'package:movie_app_mobx_and_rxdart/core/routes.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/theme_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  await configureDependencies();

  final themeStore = ThemeStore();
  themeStore.loadTheme(); // Load saved theme preference
  
  final bookmarkStore = BookmarkStore();
  bookmarkStore.loadBookmarks();

  final appRouter = AppRouter(
    themeStore: themeStore,
    bookmarkStore: bookmarkStore,
  );

  runApp(MyApp(
    themeStore: themeStore,
    bookmarkStore: bookmarkStore,
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.themeStore,
    required this.bookmarkStore,
    required this.appRouter,
  });

  final ThemeStore themeStore;
  final BookmarkStore bookmarkStore;
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_)=> MaterialApp.router(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        themeMode: themeStore.themeMode,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        routerConfig: appRouter.router,
      ),
    );
  }
}
