import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final _pageSubject = BehaviorSubject<int>.seeded(1);

  @observable
  ObservableList<ItemModel> items = ObservableList<ItemModel>();

  @observable
  bool isLoading = false;

  _HomeStore() {
    _pageSubject.listen((page) {
      fetchItems(page);
    });
  }

  void loadNextPage() {
    _pageSubject.add(_pageSubject.value + 1);
  }

  @action
  Future<void> fetchItems(int page) async {
    isLoading = true;

    await Future.delayed(Duration(seconds: 1));

    final newItems = List.generate(
      10,
          (index) => ItemModel(
        id: (page - 1) * 10 + index,
        title: "Item ${(page - 1) * 10 + index}",
      ),
    );

    items.addAll(newItems);
    isLoading = false;
  }

  void dispose() {
    _pageSubject.close();
  }
}
