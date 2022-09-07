import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_mock_datasource.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';
import 'package:ota/domain/message_and_notification/usecases/news_usecases.dart';
import 'package:ota/modules/message_and_notification/bloc/news_bloc.dart';
import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';

import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/message_server_failure_data_source.dart';

void main() {
  NewsBloc bloc = NewsBloc();

  // Usecase Success Mock
  NewsUseCases newsUseCases = NewsUseCasesImpl(
      repository: MessageAndNotificationRepositoryImpl(
          remoteDataSource: MessageAndNotificationMockDataSource(),
          internetInfo: InternetSuccessMock()));

  // Usecase Failure Mock
  NewsUseCases newsUseCasesFailure = NewsUseCasesImpl(
      repository: MessageAndNotificationRepositoryImpl(
          remoteDataSource: MessageAndNotificationServerFailureMock(),
          internetInfo: InternetSuccessMock()));
  test("News And Notification bloc success test", () async {
    expect(bloc.state.newsState, MessageViewModelState.loading);
    expect(bloc.state.newsDeleteState, MessageDeleteState.none);
    await bloc.setNewDataRequired();
    expect(bloc.isNewDataRequired, false);

    bloc.newsUseCases = newsUseCases;
    await bloc.getNewsData();
    expect(bloc.state.newsState, MessageViewModelState.success);
    expect(bloc.state.newsList.length, 10);

    await bloc.markNewsRead(0);
    expect(bloc.state.newsList[0].readFlag, true);

    await bloc.deleteNews(0);
    expect(bloc.state.newsDeleteState, MessageDeleteState.deleteSuccessful);
    expect(bloc.state.newsList.length, 9);
  });
  test("News And Notification bloc failure test", () async {
    bloc.newsUseCases = newsUseCasesFailure;
    bloc.getNewsData();
    expect(bloc.state.newsState, MessageViewModelState.pullDownLoading);

    try {
      await bloc.deleteNews(0);
      // ignore: empty_catches
    } catch (e) {}
    expect(bloc.state.newsDeleteState, MessageDeleteState.deleteUnsuccessful);
  });
}
