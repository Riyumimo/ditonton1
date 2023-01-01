import 'package:ditonton/data/datasource/movie_local_data_source.dart';
import 'package:ditonton/data/datasource/movie_remote_data_source.dart';
import 'package:ditonton/data/db/databse_helper.dart';
import 'package:ditonton/data/repositories/movie_repositories_impl.dart';
import 'package:ditonton/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecase/get_movie_recomendations.dart';
import 'package:ditonton/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecase/get_popular_movies.dart';
import 'package:ditonton/domain/usecase/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/domain/usecase/save_watchlist.dart';
import 'package:ditonton/domain/usecase/search_movies.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/search_movie_notofier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'domain/repositories/movie_repositories.dart';

final locator = GetIt.instance;

void init() {
  //provider
  locator.registerFactory(() => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator()));

  locator.registerFactory(() => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecomendations: locator(),
      getWatchListStatus: locator(),
      saveWatchList: locator(),
      removeWatchList: locator()));
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  //usescase
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecomendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchList(locator()));
  locator.registerLazySingleton(() => RemoveWatchList(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //repository
  locator.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(locator(), locator()));

  //data source
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLoacalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));

  //helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //external
  locator.registerLazySingleton(() => http.Client());
}
