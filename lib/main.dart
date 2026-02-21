import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localstorage/localstorage.dart';
import 'package:movie_app_mobx_and_rxdart/core/injection/injection.dart';
import 'package:movie_app_mobx_and_rxdart/core/routes.dart';
import 'package:movie_app_mobx_and_rxdart/stores/bookmark_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/locale_store.dart';
import 'package:movie_app_mobx_and_rxdart/stores/theme_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  await configureDependencies();

  final themeStore = ThemeStore();
  themeStore.loadTheme(); 
  
  final bookmarkStore = BookmarkStore();
  bookmarkStore.loadBookmarks();

  final localeStore = LocaleStore();
  localeStore.loadLocale(); // ✅ Load saved locale preference

  final appRouter = AppRouter(
    themeStore: themeStore,
    bookmarkStore: bookmarkStore,
    localeStore: localeStore,
  );

  runApp(MyApp(
    themeStore: themeStore,
    bookmarkStore: bookmarkStore,
    localeStore: localeStore,
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.themeStore,
    required this.bookmarkStore,
    required this.appRouter,
    required this.localeStore,

  });

  final ThemeStore themeStore;
  final BookmarkStore bookmarkStore;
  final LocaleStore localeStore;
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
        // ✅ Localization
        locale: localeStore.locale,
        supportedLocales: const [
          Locale('en'),
          Locale('id'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: appRouter.router,
      ),
    );
  }
}
