import 'package:ditonton/domain/repositories/movie_repositories.dart';

class GetWatchListStatus {
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id){
    return repository.isAddedToWatchlist(id);
  }
  
}