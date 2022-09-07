import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';
import 'package:ota/domain/message_and_notification/usecases/news_usecases.dart';
import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';
import 'package:ota/modules/message_and_notification/view_model/news_view_model.dart';

const _kMessageLimit = 20;
const String _kGlobal = "GLOBAL";

class NewsBloc extends Bloc<NewsViewModel> {
  NewsUseCases newsUseCases = NewsUseCasesImpl();
  bool _isNewDataRequired = false;
  bool get isNewDataRequired => _isNewDataRequired;
  setNewDataRequired() {
    _isNewDataRequired = false;
  }

  setInternetPopupShown() {
    state.isInternetPopupShown = true;
  }

  resetInternetPopupShown() {
    state.isInternetPopupShown = false;
  }

  clearData() {
    state.newsList.clear();
  }

  @override
  NewsViewModel initDefaultValue() {
    return NewsViewModel(
        newsList: [], newsState: MessageViewModelState.loading);
  }

  Future<void> getNewsData({
    bool refreshData = true,
  }) async {
    state.newsState = refreshData && state.newsList.isEmpty
        ? MessageViewModelState.loading
        : MessageViewModelState.pullDownLoading;
    emit(state);
    if (refreshData) {
      state.offset = 0;
    }

    Either<Failure, MessageModelDomain>? result =
        (await newsUseCases.getNewsData(
      offset: state.offset,
    ));

    state.offset++;

    if (result != null && result.isRight) {
      if (result.right.notificationInquiry?.data?.messageList != null) {
        List<MessageDataViewModel> resultNewsList = _getNewsViewModelList(
            result.right.notificationInquiry?.data?.messageList ?? []);
        _isNewDataRequired = resultNewsList.length == _kMessageLimit;

        if (refreshData) {
          state.newsList.clear();
        }

        if (state.newsList.isEmpty) {
          state.newsList = resultNewsList;
        } else {
          state.newsList.addAll(resultNewsList);
        }
      }

      state.newsState = MessageViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      if (state.newsState == MessageViewModelState.loading) {
        _isNewDataRequired = true;
        state.newsState = MessageViewModelState.internetFailure;
        emit(state);
      } else {
        _isNewDataRequired = true;
        state.newsState = MessageViewModelState.internetFailureRefresh;
        emit(state);
      }
    } else {
      _isNewDataRequired = true;
      if (result?.left is InternetFailure) {
        state.newsState = MessageViewModelState.internetFailure;
      } else {
        state.newsState = MessageViewModelState.failure;
      }
      emit(state);
    }
  }

  List<MessageDataViewModel> _getNewsViewModelList(
      List<MessageList> messageList) {
    return messageList.map((e) => MessageDataViewModel.formModel(e)).toList();
  }

  Future<void> markNewsRead(int index) async {
    Either<Failure, bool>? result = (await newsUseCases.readNews(
        type: _kGlobal, messageId: state.newsList[index].messageId));
    if (result != null && result.isRight) {
      if (result.right) {
        state.newsList[index].readFlag = true;
        emit(state);
      }
    }
  }

  Future<void> deleteNews(int index) async {
    Either<Failure, bool>? result = (await newsUseCases.deleteNews(
      type: _kGlobal,
      messageId: state.newsList[index].messageId,
    ));
    if (result != null && result.isRight) {
      if (result.right) {
        state.newsDeleteState = MessageDeleteState.deleteSuccessful;
        state.newsList.remove(state.newsList[index]);
        emit(state);
        return;
      }
    } else if (result?.left is InternetFailure) {
      state.newsDeleteState = MessageDeleteState.internetFailure;
      emit(state);
    } else {
      state.newsDeleteState = MessageDeleteState.deleteUnsuccessful;
      emit(state);
    }
  }
}
