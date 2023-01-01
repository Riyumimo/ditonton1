class ServerException implements Exception {}

class DatabaseException1 implements Exception {
  final String message;

  DatabaseException1(this.message);
}
