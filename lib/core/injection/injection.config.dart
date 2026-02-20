// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app_mobx_and_rxdart/core/injection/network_module.dart'
    as _i463;
import 'package:movie_app_mobx_and_rxdart/core/remote/movie_api.dart' as _i527;
import 'package:movie_app_mobx_and_rxdart/core/repository/movie_repository.dart'
    as _i328;
import 'package:movie_app_mobx_and_rxdart/stores/home_store.dart' as _i769;
import 'package:movie_app_mobx_and_rxdart/stores/search_store.dart' as _i831;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.factory<_i361.Dio>(() => networkModule.getDio());
    gh.lazySingleton<_i527.MovieApi>(
        () => networkModule.movieApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i328.MovieRepository>(
        () => _i328.MovieRepository(gh<_i527.MovieApi>()));
    gh.factory<_i831.SearchStore>(
        () => _i831.SearchStore(gh<_i328.MovieRepository>()));
    gh.singleton<_i769.HomeStore>(
        () => _i769.HomeStore(gh<_i328.MovieRepository>()));
    return this;
  }
}

class _$NetworkModule extends _i463.NetworkModule {}
