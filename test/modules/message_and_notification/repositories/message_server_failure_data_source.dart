import 'package:ota/common/network/exceptions.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_data_source.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';

class MessageAndNotificationServerFailureMock
    extends MessageAndNotificationRemoteDataSource {
  @override
  Future<bool> deleteMessage(
      {required String type, required int messageId}) {
    throw ServerException(null);
  }

  @override
  Future<MessageModelDomain> getNewsData(int offset) {
    throw ServerException(null);
  }

  @override
  Future<MessageModelDomain> getReceiptsData(int offset) {
    throw ServerException(null);
  }

  @override
  Future<bool> readMessage({required String type, required int messageId}) {
    throw ServerException(null);
  }
}
