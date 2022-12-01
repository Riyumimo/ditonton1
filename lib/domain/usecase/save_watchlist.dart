import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';
import '../../common/failure.dart';

class SaveWatchList {
  final MovieRepository repository;

  SaveWatchList(this.repository);

  Future<Either<Failure,String>> execute(MovieDetail movie){
    return repository.saveWatchList(movie);
  }
}