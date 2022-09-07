import 'package:graphql_flutter/graphql_flutter.dart';

/// Failures for APIs.
abstract class Failure {
  /// Get message message.
  Future<String> getErrorMessage();

  /// Get error code.
  Future<int> getErrorCode();
}

/// Server failure handler.
class ServerFailure extends Failure {
  OperationException? exception;
  ServerFailure({this.exception});

  /// Get message message.
  @override
  Future<String> getErrorMessage() async {
    return exception.toString();
  }

  @override
  Future<int> getErrorCode() async {
    return -20000;
  }
}

///Method channel Failure handler
class ChannelFailure extends Failure {
  String errorMessage;
  ChannelFailure(this.errorMessage);
  @override
  Future<int> getErrorCode() async {
    return 777;
  }

  @override
  Future<String> getErrorMessage() async {
    return errorMessage;
  }
}

/// Internet failure handler.
class InternetFailure extends Failure {
  @override
  Future<String> getErrorMessage() async {
    return "Internet connection not found!";
  }

  /// Get error code.
  @override
  Future<int> getErrorCode() async {
    return -10000;
  }
}

enum SuccessResponse {
  success,
}
