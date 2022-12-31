import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecase/get_popular_movies.dart';
import 'package:ditonton/domain/usecase/get_top_rated_movies.dart';
import 'package:flutter/cupertino.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMovieState = RequestState.Empty;
  RequestState get popularMovieState => _popularMovieState;

  var _topRateMovies = <Movie>[];
  List<Movie> get topRateMovies => _topRateMovies;

  RequestState _topRateMovieState = RequestState.Empty;
  RequestState get topRateMovieState => _topRateMovieState;

  String _message = '';
  String get message => _message;

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  MovieListNotifier(
      {required this.getNowPlayingMovies,
      required this.getPopularMovies,
      required this.getTopRatedMovies});

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
    }, (moviesdata) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingMovies = moviesdata;
      notifyListeners();
    });
  }

  Future<void> fetchPopularMovies() async {
    _popularMovieState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold((failure) {
      _popularMovieState = RequestState.Error;
      _message = failure.message;
    }, (moviesdata) {
      _popularMovieState = RequestState.Loaded;
      _popularMovies = moviesdata;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedMovies() async {
    _topRateMovieState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold((failure) {
      _topRateMovieState = RequestState.Error;
      _message = failure.message;
    }, (moviesdata) {
      _topRateMovieState = RequestState.Loaded;
      _topRateMovies = moviesdata;
      notifyListeners();
    });
  }
}
