import 'package:graphql_flutter/graphql_flutter.dart';

class ServerException implements Exception {
  OperationException? exception;
  ServerException(this.exception);
}
