import 'package:ditonton/data/datasource/movie_local_data_source.dart';
import 'package:ditonton/data/datasource/movie_remote_data_source.dart';
import 'package:ditonton/data/db/databse_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([DatabaseHelper,MovieRemoteDataSource,MovieLocalDataSource],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
