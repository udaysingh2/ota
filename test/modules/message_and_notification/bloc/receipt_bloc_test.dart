import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/message_and_notification/data_source/message_and_notification_mock_datasource.dart';
import 'package:ota/domain/message_and_notification/repository/message_and_notification_repository.dart';
import 'package:ota/domain/message_and_notification/usecases/receipt_usecases.dart';
import 'package:ota/modules/message_and_notification/bloc/receipt_bloc.dart';
import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';

import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/message_server_failure_data_source.dart';

void main() {
  ReceiptBloc bloc = ReceiptBloc();

  // Usecase Success Mock
  ReceiptUseCases receiptUseCases = ReceiptUseCasesImpl(
      repository: MessageAndNotificationRepositoryImpl(
          remoteDataSource: MessageAndNotificationMockDataSource(),
          internetInfo: InternetSuccessMock()));

  // Usecase Failure Mock
  ReceiptUseCases receiptUseCasesFailure = ReceiptUseCasesImpl(
      repository: MessageAndNotificationRepositoryImpl(
          remoteDataSource: MessageAndNotificationServerFailureMock(),
          internetInfo: InternetSuccessMock()));
  test("Receipt bloc success test", () async {
    expect(bloc.state.receiptState, MessageViewModelState.none);
    expect(bloc.state.receiptDeleteState, MessageDeleteState.none);
    await bloc.setNewDataRequired();
    expect(bloc.isNewDataRequired, false);

    bloc.receiptUseCases = receiptUseCases;
    await bloc.getReceiptData();
    expect(bloc.state.receiptState, MessageViewModelState.success);
    expect(bloc.state.receiptList.length, 10);

    await bloc.markReceiptRead(0);
    expect(bloc.state.receiptList[0].readFlag, true);

    await bloc.deleteReceipt(0);
    expect(bloc.state.receiptDeleteState, MessageDeleteState.deleteSuccessful);
    expect(bloc.state.receiptList.length, 9);
  });
  test("Receipt bloc failure test", () async {
    bloc.receiptUseCases = receiptUseCasesFailure;
    bloc.getReceiptData();
    expect(bloc.state.receiptState, MessageViewModelState.pullDownLoading);

    try {
      await bloc.deleteReceipt(0);
      // ignore: empty_catches
    } catch (e) {}
    expect(
        bloc.state.receiptDeleteState, MessageDeleteState.deleteUnsuccessful);
  });
}
