import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';

import '../../common/failure.dart';

class RemoveWatchList {
  final MovieRepository repository;

  RemoveWatchList(this.repository);

Future<Either<Failure,String>> execute(MovieDetail movie){
    return repository.removeWatchList(movie);
  }
  
}