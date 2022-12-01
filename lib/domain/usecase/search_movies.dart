import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);
  
  Future<Either<Failure,List<Movie>>> execute(String query){
    return repository.searchMovies(query);
  }
}