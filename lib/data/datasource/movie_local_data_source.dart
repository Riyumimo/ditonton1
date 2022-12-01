import '../../common/exceptions.dart';
import '../db/databse_helper.dart';
import '../models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchList(MovieTable movie);
  Future<String> removeWatchList(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchListMovie();
}

class MovieLoacalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLoacalDataSourceImpl({required this.databaseHelper});
  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchListMovie() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((e) => MovieTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchList(movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);

      return 'Added to WatchList';
    } catch (e) {
      throw DatabaseException1(e.toString());
    }
  }

  @override
  Future<String> removeWatchList(movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException1(e.toString());
    }
  }
}
