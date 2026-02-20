import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_app_mobx_and_rxdart/core/repository/movie_repository.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

part 'home_store.g.dart';

@singleton
class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore(this.repository);

  final MovieRepository repository;

  @observable
  ObservableList<MovieResponse> movies = ObservableList<MovieResponse>();

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingMore = false; // ✅ loading tambahan saat scroll

  @observable
  String? errorMessage;

  @observable
  int currentPage = 1;

  @observable
  int totalPages = 1;

  @computed
  bool get hasMore => currentPage < totalPages;

  @action
  Future<void> load() async {
    // Reset state untuk load awal
    currentPage = 1;
    totalPages = 1;
    isLoading = true;
    errorMessage = null;

    final result = await repository.getPopular(page: 1);

    runInAction(() {
      result.fold(
            (error) {
          errorMessage = error.toString();
        },
            (response) {
          movies
            ..clear()
            ..addAll(response.results ?? []);
          currentPage = response.page ?? 1;
          totalPages = response.totalPages ?? 1;
        },
      );
      isLoading = false;
    });
  }

  @action
  Future<void> loadMore() async {
    // Jangan load jika sedang loading atau sudah halaman terakhir
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    final nextPage = currentPage + 1;

    final result = await repository.getPopular(page: nextPage);

    runInAction(() {
      result.fold(
            (error) {
          errorMessage = error.toString();
        },
            (response) {
          // ✅ Append, bukan replace
          movies.addAll(response.results ?? []);
          currentPage = response.page ?? currentPage;
          totalPages = response.totalPages ?? totalPages;
        },
      );
      isLoadingMore = false;
    });
  }
}