import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

import '../../common/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure,List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure,List<Movie>>> getPopularMovies();
  Future<Either<Failure,List<Movie>>> getTopRatedMovies();
  Future<Either<Failure,MovieDetail>> getMovieDetails(int id);
  Future<Either<Failure,List<Movie>>> getMovieRecomendations(int id);
  Future<Either<Failure,List<Movie>>> searchMovies(String query);
  Future<Either<Failure,String>> saveWatchList(MovieDetail movie);
  Future<Either<Failure,String>> removeWatchList(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure,List<Movie>>> getWatchlistMovie();

  
}