import 'package:mobx/mobx.dart';
import '../models/item_model.dart';

part 'bookmark_store.g.dart';

class BookmarkStore = _BookmarkStore with _$BookmarkStore;

abstract class _BookmarkStore with Store {
  @observable
  ObservableList<ItemModel> bookmarks = ObservableList<ItemModel>();

  @action
  void toggleBookmark(ItemModel item) {
    if (bookmarks.any((e) => e.id == item.id)) {
      bookmarks.removeWhere((e) => e.id == item.id);
    } else {
      bookmarks.add(item);
    }
  }

  bool isBookmarked(int id) {
    return bookmarks.any((e) => e.id == id);
  }
}
