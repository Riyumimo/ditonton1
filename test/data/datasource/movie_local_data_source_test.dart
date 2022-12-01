import 'package:ditonton/common/exceptions.dart';
import 'package:ditonton/data/datasource/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'helper/test_helper.mocks.dart';

void main() {
  late MovieLoacalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLoacalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return succses message when inset to watchlist is sucsess',
        () async {
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((realInvocation) async => 1);

      //act
      final result = await dataSource.insertWatchList(testMovieTable);

      expect(result, 'Added to WatchList');
    });
  });

  test('should throw DatabaseException when insert to database is failed',
      () async {
    // arrange
    when(mockDatabaseHelper.insertWatchlist(testMovieTable))
        .thenThrow(Exception());
    // act
    final call = dataSource.insertWatchList(testMovieTable);
    // assert
    expect(() => call, throwsA(isA<DatabaseException1>()));
  });
  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchList(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchList(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException1>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchListMovie();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
