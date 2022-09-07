import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';
import 'package:ota/domain/message_and_notification/usecases/receipt_usecases.dart';
import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';
import 'package:ota/modules/message_and_notification/view_model/receipts_view_model.dart';

const _kMessageLimit = 20;
const String _kIndividual = "INDIVIDUAL";

class ReceiptBloc extends Bloc<ReceiptsViewModel> {
  ReceiptUseCases receiptUseCases = ReceiptUseCasesImpl();
  bool _isNewDataRequired = false;
  bool get isNewDataRequired => _isNewDataRequired;
  setNewDataRequired() {
    _isNewDataRequired = false;
  }

  setInternetPopupShown() {
    state.isInternetPopUpShown = true;
  }

  resetInternetPopupShown() {
    state.isInternetPopUpShown = false;
  }

  clearData() {
    state.receiptList.clear();
    //emit(state);
  }

  @override
  ReceiptsViewModel initDefaultValue() {
    return ReceiptsViewModel(receiptList: []);
  }

  Future<void> getReceiptData({
    bool refreshData = true,
  }) async {
    state.receiptState = refreshData && state.receiptList.isEmpty
        ? MessageViewModelState.loading
        : MessageViewModelState.pullDownLoading;
    emit(state);
    if (refreshData) {
      state.offset = 0;
    }

    Either<Failure, MessageModelDomain>? result =
        (await receiptUseCases.getReceiptsData(
      offset: state.offset,
    ));

    if (result != null && result.isRight) {
      if (result.right.notificationInquiry?.data?.messageList != null) {
        List<MessageDataViewModel> resultReceiptList = _getNewsViewModelList(
            result.right.notificationInquiry?.data?.messageList ?? []);
        _isNewDataRequired = resultReceiptList.length == _kMessageLimit;
        state.offset++;

        if (refreshData) {
          state.receiptList.clear();
        }

        if (state.receiptList.isEmpty) {
          state.receiptList = resultReceiptList;
        } else {
          state.receiptList.addAll(resultReceiptList);
        }
      }
      state.receiptState = MessageViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      if (state.receiptState == MessageViewModelState.loading) {
        _isNewDataRequired = true;
        state.receiptState = MessageViewModelState.internetFailure;
        emit(state);
      } else {
        _isNewDataRequired = true;
        state.receiptState = MessageViewModelState.internetFailureRefresh;
        emit(state);
      }
    } else {
      _isNewDataRequired = true;
      if (result?.left is InternetFailure) {
        state.receiptState = MessageViewModelState.internetFailure;
      } else {
        state.receiptState = MessageViewModelState.failure;
      }
      emit(state);
    }
  }

  List<MessageDataViewModel> _getNewsViewModelList(
      List<MessageList> messageList) {
    return messageList.map((e) => MessageDataViewModel.formModel(e)).toList();
  }

  Future<void> markReceiptRead(int index) async {
    Either<Failure, bool>? result = (await receiptUseCases.readReceipts(
        type: _kIndividual, messageId: state.receiptList[index].messageId));
    if (result != null && result.isRight) {
      if (result.right) {
        state.receiptList[index].readFlag = true;
        emit(state);
      }
    }
  }

  Future<void> deleteReceipt(int index) async {
    Either<Failure, bool>? result = (await receiptUseCases.deleteReceipts(
      type: _kIndividual,
      messageId: state.receiptList[index].messageId,
    ));
    if (result != null && result.isRight) {
      if (result.right) {
        state.receiptDeleteState = MessageDeleteState.deleteSuccessful;
        state.receiptList.remove(state.receiptList[index]);
        emit(state);
        return;
      }
    } else {
      if (result?.left is InternetFailure) {
        state.receiptDeleteState = MessageDeleteState.internetFailure;
      } else {
        state.receiptDeleteState = MessageDeleteState.deleteUnsuccessful;
      }
      emit(state);
    }
  }
}
