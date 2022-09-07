import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_mock_datasource.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';

import '../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/message_server_failure_data_source.dart';

void main() {
  MessageAndNotificationRepository?
      messageAndNotificationRepositoryServerException;
  MessageAndNotificationRepository? messageAndNotificationRepositoryMock;
  MessageAndNotificationRepository?
      messageAndNotificationRepositoryInternetFailure;
  setUpAll(() async {
    /// Code coverage for default implementation.
    messageAndNotificationRepositoryMock =
        MessageAndNotificationRepositoryImpl();

    /// Code coverage for mock class
    messageAndNotificationRepositoryMock = MessageAndNotificationRepositoryImpl(
        remoteDataSource: MessageAndNotificationMockDataSource(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    messageAndNotificationRepositoryServerException =
        MessageAndNotificationRepositoryImpl(
            remoteDataSource: MessageAndNotificationServerFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    messageAndNotificationRepositoryInternetFailure =
        MessageAndNotificationRepositoryImpl(
            remoteDataSource: MessageAndNotificationMockDataSource(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Message Repository analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultNews =
        await messageAndNotificationRepositoryMock!.getNewsData(0);

    /// Get model from mock data.
    final MessageModelDomain modelNews = consentResultNews.right;

    /// Condition check for hotel value null
    expect(modelNews.notificationInquiry != null, true);

    /// Consent user cases impl
    final consentResultReceipt =
        await messageAndNotificationRepositoryMock!.getReceiptsData(0);

    /// Get model from mock data.
    final MessageModelDomain modelReceipt = consentResultReceipt.right;

    /// Condition check for hotel value null
    expect(modelReceipt.notificationInquiry != null, true);

    /// Consent user cases impl
    final readMessage = await messageAndNotificationRepositoryMock!
        .readMessage(type: "PROMOTION", messageId: 1);

    /// Get model from mock data.
    final bool? readFlag = readMessage?.right;

    /// Condition check for hotel value null
    expect(readFlag, true);

    /// Consent user cases impl
    final deleteMessage = await messageAndNotificationRepositoryMock!
        .deleteMessage(type: "PROMOTION", messageId: 1);

    /// Get model from mock data.
    final bool? deleteFlag = deleteMessage?.right;

    /// Condition check for hotel value null
    expect(deleteFlag, true);
  });

  test(
      'Message And Notification analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResultNews =
        await messageAndNotificationRepositoryInternetFailure!.getNewsData(0);

    expect(consentResultNews.isLeft, true);

    /// Consent user cases impl
    final consentResultReceipt =
        await messageAndNotificationRepositoryInternetFailure!
            .getReceiptsData(0);

    expect(consentResultReceipt.isLeft, true);

    /// Consent user cases impl
    final readMessage = await messageAndNotificationRepositoryInternetFailure!
        .readMessage(type: "PROMOTION", messageId: 1);

    expect(readMessage?.isLeft, true);

    /// Consent user cases impl
    final deleteMessage = await messageAndNotificationRepositoryInternetFailure!
        .deleteMessage(type: "PROMOTION", messageId: 1);

    expect(deleteMessage?.isLeft, true);
  });

  test(
      'Hotel Booking List analytics Repository '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResultNews =
        await messageAndNotificationRepositoryServerException!.getNewsData(0);

    expect(consentResultNews.isLeft, true);

    /// Consent user cases impl
    final consentResultReceipt =
        await messageAndNotificationRepositoryServerException!
            .getReceiptsData(0);

    expect(consentResultReceipt.isLeft, true);

    /// Consent user cases impl
    final readMessage = await messageAndNotificationRepositoryServerException!
        .readMessage(type: "PROMOTION", messageId: 1);

    expect(readMessage?.isLeft, true);

    /// Consent user cases impl
    final deleteMessage = await messageAndNotificationRepositoryServerException!
        .deleteMessage(type: "PROMOTION", messageId: 1);

    expect(deleteMessage?.isLeft, true);
  });
}
