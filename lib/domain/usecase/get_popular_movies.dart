import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';
import '../../common/failure.dart';
import '../entities/movie.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

Future<Either<Failure,List<Movie>>> execute(){
    return repository.getPopularMovies();
  }
  
}