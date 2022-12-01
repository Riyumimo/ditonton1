import 'dart:convert';

import 'package:ditonton/common/exceptions.dart';
import 'package:ditonton/data/datasource/movie_remote_data_source.dart';
import 'package:ditonton/data/models/movie_detail.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import 'helper/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  MovieRemoteDataSourceImpl? dataSourceImpl;
  MockHttpClient? mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = MovieRemoteDataSourceImpl(client: mockHttpClient!);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;
    print(tMovieList);

    test('should return list movie model when the response is 200', () async {
      when(mockHttpClient!
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));

      final result = await dataSourceImpl!.getNowPlayingMovies();

      expect(result, equals(tMovieList));
    });

    test('should throw a ServerException when the response is 404 or other',
        () async {
      when(mockHttpClient!
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer(
              (realInvocation) async => http.Response('Not Found', 404));

      final call = dataSourceImpl!.getNowPlayingMovies();
      print(call);
      expect(call, throwsA(isA<ServerException>()));
    });
  });
  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));
    //print(tMovieDetail);
    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient!.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSourceImpl!.getMoviesDetails(tId);
      // assert

      expect(result, equals(tMovieDetail));
    });
    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient!.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl!.getMoviesDetails(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('When get Recomendation ', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;
    final tId = 1;

    test('should return list recomednation if status code 200', () async {
      when(mockHttpClient!
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/movie_recommendations.json'), 200));
      // act
      final result = await dataSourceImpl!.getMoviesRecomendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });
    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient!
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl!.getMoviesRecomendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get search movie', () {
    final tSearchResult = MovieResponse.fromJson(
            jsonDecode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response is 200', () async {
      when(mockHttpClient!
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));

      final result = await dataSourceImpl!.searchMovies(tQuery);

      expect(result, tSearchResult);
    });
    test('should return error of movies when response is 404 or other',
        () async {
      when(mockHttpClient!
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final result = dataSourceImpl!.searchMovies(tQuery);

      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated movie', () {
    final tRatedMovie = MovieResponse.fromJson(
            jsonDecode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list movie of when response 200', () async {
      when(mockHttpClient!.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 200));

      //act
      final result = await dataSourceImpl!.getTopRatedMovies();

      expect(result, tRatedMovie);
    });

    test('should return throw movie of when response other', () async {
      when(mockHttpClient!.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      //act
      final result = dataSourceImpl!.getTopRatedMovies();

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
