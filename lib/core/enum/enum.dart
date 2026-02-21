import 'package:movie_app_mobx_and_rxdart/core/l10n/l10n.dart';

enum MovieCategory { popular, nowPlaying, upcoming }

extension MovieCategoryX on MovieCategory {
  String label(AppLocalizations l10n) {
    switch (this) {
      case MovieCategory.popular:
        return l10n.categoryPopular;
      case MovieCategory.nowPlaying:
        return l10n.categoryNowPlaying;
      case MovieCategory.upcoming:
        return l10n.categoryUpcoming;
    }
  }
}