import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';

import '../../common/failure.dart';
import '../entities/movie_detail.dart';

class GetMovieRecomendations {
  final MovieRepository repository;

  GetMovieRecomendations(this.repository);

  Future<Either<Failure,List<Movie>>> execute(int id){
    return repository.getMovieRecomendations(id);
  }
  
}