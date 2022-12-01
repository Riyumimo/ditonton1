import 'package:ditonton/data/db/databse_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([DatabaseHelper],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
