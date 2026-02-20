import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_app_mobx_and_rxdart/core/repository/movie_repository.dart';
import 'package:movie_app_mobx_and_rxdart/models/movie_response.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

@injectable
abstract class _HomeStore with Store {
  _HomeStore(this.repository);

  final MovieRepository repository;

  @observable
  ObservableList<MovieResponse> movies = ObservableList<MovieResponse>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> load() async {
    isLoading = true;
    errorMessage = null;

    final result = await repository.getPopular();

    result.fold(
          (error) {
        errorMessage = error.toString();
      },
          (data) {
        movies
          ..clear()
          ..addAll(data);
      },
    );

    isLoading = false;
  }
}
