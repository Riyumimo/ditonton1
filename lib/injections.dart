import 'package:ditonton/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecase/get_movie_recomendations.dart';
import 'package:ditonton/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecase/get_popular_movies.dart';
import 'package:ditonton/domain/usecase/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecase/search_movies.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:get_it/get_it.dart';

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

  //usescase
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecomendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
}
