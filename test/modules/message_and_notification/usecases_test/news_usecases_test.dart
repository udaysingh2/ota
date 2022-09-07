import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_mock_datasource.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';
import 'package:ota/domain/message_and_notification/usecases/news_usecases.dart';

import '../../hotel/repositories/internet_success_mock.dart';

void main() {
  NewsUseCases? newsUseCases;
  setUpAll(() async {
    /// Code coverage for default implementation.
    newsUseCases = NewsUseCasesImpl();

    /// Code coverage for mock class
    newsUseCases = NewsUseCasesImpl(
        repository: MessageAndNotificationRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: MessageAndNotificationMockDataSource()));
  });

  test(
      'News analytics usecases '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await newsUseCases!.getNewsData(offset: 0);

    /// Get model from mock data.
    final MessageModelDomain model = consentResult!.right;

    /// Condition check for notification Inquiry null
    expect(model.notificationInquiry != null, true);

    /// Consent user cases impl
    final readNews =
        await newsUseCases!.readNews(type: "PROMORION", messageId: 1);

    /// Get model from mock data.
    final bool? readFlag = readNews?.right;

    /// Condition check for notification Inquiry null
    expect(readFlag, true);

    /// Consent user cases impl
    final deleteNews =
        await newsUseCases!.deleteNews(type: "PROMORION", messageId: 1);

    /// Get model from mock data.
    final bool? deleteFlag = deleteNews?.right;

    /// Condition check for notification Inquiry null
    expect(deleteFlag, true);
  });
}
