import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecase/get_movie_recomendations.dart';
import 'package:ditonton/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/domain/usecase/save_watchlist.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to WatchList';
  static const watchlistRemoveSuccessMessage = 'Removed from WatchList';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecomendations getMovieRecomendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchList saveWatchList;
  final RemoveWatchList removeWatchList;

  MovieDetailNotifier(
      {required this.getMovieDetail,
      required this.getMovieRecomendations,
      required this.getWatchListStatus,
      required this.saveWatchList,
      required this.removeWatchList});

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecomendation = [];
  List<Movie> get movieRecomendation => _movieRecomendation;

  RequestState _movieRecomendationState = RequestState.Empty;
  RequestState get movieRecomendationState => _movieRecomendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchList = false;
  bool get isAddedToWatchList => _isAddedToWatchList;

  //eksekusi function
  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recomendationResult = await getMovieRecomendations.execute(id);
    detailResult.fold((failure) {
      _movieState = RequestState.Error;
      _message = failure.message;
    }, (movie) {
      _movieRecomendationState = RequestState.Loading;
      _movie = movie;
      notifyListeners();
      recomendationResult.fold((failure) {
        _movieRecomendationState = RequestState.Error;
        _message = failure.message;
      }, (movies) {
        _movieRecomendationState = RequestState.Loaded;
        _movieRecomendation = movies;
      });
      _movieState = RequestState.Loaded;
      notifyListeners();
    });
  }

  //watch list function

  Future<void> loadWatchListStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedToWatchList = result;
    notifyListeners();
  }

  String _watchlistmessage = '';
  String get watchListMessage => _watchlistmessage;

  Future<void> addWatchList(MovieDetail movie) async {
    final result = await saveWatchList.execute(movie);
    await result.fold((failure) {
      _watchlistmessage = failure.message;
    }, (successMessage) {
      _watchlistmessage = successMessage;
    });

    await loadWatchListStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchList.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistmessage = failure.message;
      },
      (successMessage) async {
        _watchlistmessage = successMessage;
      },
    );

    await loadWatchListStatus(movie.id);
  }
}
