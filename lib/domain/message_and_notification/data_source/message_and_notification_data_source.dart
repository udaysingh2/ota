import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_message.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';

/// Interface for Messages remote data source.
abstract class MessageAndNotificationRemoteDataSource {
  /// Call API to get the Message Screen details.
  ///
  /// to handle the Failure or result data.
  Future<MessageModelDomain> getNewsData(int offset);

  /// Call API to mark news as read
  Future<bool> readMessage({
    required String type,
    required int messageId,
  });

  /// Call API to delete news
  Future<bool> deleteMessage({
    required String type,
    required int messageId,
  });

// Get receiptsData
  Future<MessageModelDomain> getReceiptsData(int offset);
}

/// MessageRemoteDataSourceImpl will contain the MessageRemoteDataSource implementation.
class MessageAndNotificationRemoteDataSourceImpl
    implements MessageAndNotificationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  MessageAndNotificationRemoteDataSourceImpl(
      {GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<MessageModelDomain> getNewsData(int offset) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.notificationInquiry,
        query: QueriesMessage.getNewsData(offset));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return MessageModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<MessageModelDomain> getReceiptsData(int offset) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.notificationInquiry,
        query: QueriesMessage.getReceiptsData(offset));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return MessageModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<bool> readMessage(
      {required String type, required int messageId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.notificationRead,
        query: QueriesMessage.markMessagesRead(type, messageId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return !result.hasException;
    }
  }

  @override
  Future<bool> deleteMessage(
      {required String type, required int messageId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.notificationRemove,
        query: QueriesMessage.deleteMessage(type, messageId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return !result.hasException;
    }
  }
}
