import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure,List<Movie>> getNowPlayingMovies();
  
}