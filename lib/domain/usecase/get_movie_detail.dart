import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);
  
  Future<Either<Failure,MovieDetail>> execute(int id){
    return repository.getMovieDetails(id);
  }
}