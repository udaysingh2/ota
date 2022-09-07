import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_data_source.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';

import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/message_graphql_mock.dart';

void main() {
  GraphQlResponse graphQlResponseMessage = MockMessageAndNotificationGraphQl();
  MessageAndNotificationRepository? messageAndNotificationRepository;

  messageAndNotificationRepository = MessageAndNotificationRepositoryImpl();

  /// Code coverage for mock class
  MessageAndNotificationRemoteDataSourceImpl.setMock(graphQlResponseMessage);
  messageAndNotificationRepository = MessageAndNotificationRepositoryImpl(
      remoteDataSource: MessageAndNotificationRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Message And Notification Data Source", () {
    MessageAndNotificationRemoteDataSource
        messageAndNotificationRemoteDataSource =
        MessageAndNotificationRemoteDataSourceImpl();
    MessageAndNotificationRemoteDataSourceImpl.setMock(graphQlResponseMessage);

    messageAndNotificationRemoteDataSource.getNewsData(0);
    messageAndNotificationRemoteDataSource.getReceiptsData(0);
    messageAndNotificationRemoteDataSource.readMessage(
        type: "PROMOTION", messageId: 1);
    messageAndNotificationRemoteDataSource.deleteMessage(
        type: "PROMOTION", messageId: 1);
  });
  test(
      'Message And Notification analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultNews =
        await messageAndNotificationRepository!.getNewsData(0);

    expect(consentResultNews.isLeft, false);

    /// Consent user cases impl
    final consentResultReceipt =
        await messageAndNotificationRepository.getReceiptsData(0);

    expect(consentResultReceipt.isLeft, false);

    /// Consent user cases impl
    final readMessage = await messageAndNotificationRepository.readMessage(
        type: "PROMOTION", messageId: 1);

    expect(readMessage?.isLeft, false);

    /// Consent user cases impl
    final deleteMessage = await messageAndNotificationRepository.deleteMessage(
        type: "PROMOTION", messageId: 1);

    expect(deleteMessage?.isLeft, false);
  });
}
