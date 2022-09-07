import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/failures.dart';

void main() {
  test("ServerFailure test", () async {
    OperationException exception = OperationException();
    ServerFailure serverFailure = ServerFailure(exception: exception);
    // expect(serverFailure is ServerFailure, true);
    expect(await serverFailure.getErrorMessage(),
        'OperationException(linkException: null, graphqlErrors: [])');
    expect(await serverFailure.getErrorCode(), -20000);
  });

  test("InternetFailure test", () async {
    InternetFailure internetFailure = InternetFailure();
    // expect(internetFailure is InternetFailure, true);
    expect(await internetFailure.getErrorMessage(),
        'Internet connection not found!');
    expect(await internetFailure.getErrorCode(), -10000);
  });
}
