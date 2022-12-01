import 'dart:io';

import 'package:ditonton/common/exceptions.dart';
import 'package:ditonton/data/datasource/movie_local_data_source.dart';
import 'package:ditonton/data/datasource/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/movie_repositories.dart';

class MovieRepositoryImpl implements MovieRepository {
final MovieRemoteDataSource remoteDataSource;
final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async{
   try {
     final result = await remoteDataSource.getNowPlayingMovies();
     return Right(result.map((e) => e.toEntity()).toList());
   } on ServerException {
    return Left(ServerFailure(''));
   } on SocketException{
    return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }
  @override
  Future<Either<Failure, MovieDetail>> getMovieDetails(int id) async{
   try {
     final result = await remoteDataSource.getMoviesDetails(id);
     return Right(result.toEntity());
   } on ServerException {
    return Left(ServerFailure(''));
   } on SocketException{
    return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecomendations(int id) async{
    try {
      
    final result = await remoteDataSource.getMoviesRecomendations(id);
    return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
    return Left(ServerFailure(''));
   } on SocketException{
    return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }


  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async{
    try {
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException {
    return Left(ServerFailure(''));
   } on SocketException{
    return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async{
    try {
      final result = await remoteDataSource.getTopRatedMovies();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException {
    return Left(ServerFailure(''));
   } on SocketException{
    return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async{
    try {
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
    return Left(ServerFailure(''));
   } on SocketException{
    return Left(ConnectionFailure('Failed to connect to the network'));
   }
  }
  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovie() async{
    final result = await localDataSource.getWatchListMovie();
    return Right(result.map((e) => e.toEnity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async{
    final result = await localDataSource.getMovieById(id);

    return result != null;
  }
  
  @override
  Future<Either<Failure, String>> removeWatchList(MovieDetail movie) async{
   try {
     final result = await localDataSource.removeWatchList(MovieTable.fromEntity(movie));
     return Right(result);
   } on DatabaseException1 catch(e){
    return Left(DatabaseFailure(e.message));
   }
  }
  
  @override
  Future<Either<Failure, String>> saveWatchList(MovieDetail movie) async{
    try {
      final result = await localDataSource.insertWatchList(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException1 catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e){
      throw e;
    }
  }

  
}