import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_app_mobx_and_rxdart/core/repository/movie_repository.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';
import 'package:rxdart/rxdart.dart';

part 'search_store.g.dart';

@injectable
class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  _SearchStore(this.repository) {
    _setupDebounce();
  }

  final MovieRepository repository;

  final _querySubject = BehaviorSubject<String>();

  @observable
  ObservableList<MovieResponse> movies = ObservableList<MovieResponse>();

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingMore = false;

  @observable
  String? errorMessage;

  @observable
  int currentPage = 1;

  @observable
  int totalPages = 1;

  @computed
  bool get hasMore => currentPage < totalPages;

  // --- Actions ---
  @action
  void setSearchQuery(String query) {
    _querySubject.add(query);
  }

  void _setupDebounce() {
    _querySubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((query) {
      if (query.isEmpty) {
        runInAction(() {
          movies.clear();
          errorMessage = null;
        });
      } else {
        _search(query);
      }
    });
  }

  @action
  Future<void> _search(String query) async {
    isLoading = true;
    errorMessage = null;
    currentPage = 1;

    final result = await repository.search(query: query, page: 1);
    runInAction(() {
      result.fold(
            (error) => errorMessage = error.toString(),
            (response) {
          movies.clear();
          movies.addAll(response.results ?? []);
          currentPage = response.page ?? 1;
          totalPages = response.totalPages ?? 1;
        },
      );
      isLoading = false;
    });
  }

  @action
  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore || _querySubject.value.isEmpty) return;
    isLoadingMore = true;
    final nextPage = currentPage + 1;

    final result = await repository.search(query: _querySubject.value, page: nextPage);
    runInAction(() {
      result.fold(
            (error) => errorMessage = error.toString(),
            (response) {
          movies.addAll(response.results ?? []);
          currentPage = response.page ?? currentPage;
        },
      );
      isLoadingMore = false;
    });
  }

  @action
  void dispose() {
    _querySubject.close();
  }
}