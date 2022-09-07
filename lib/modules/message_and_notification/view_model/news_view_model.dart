import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';

class NewsViewModel {
  List<MessageDataViewModel> newsList;
  MessageViewModelState newsState;
  MessageDeleteState newsDeleteState;
  int offset;
  bool isInternetPopupShown = false;

  NewsViewModel({
    required this.newsList,
    this.newsState = MessageViewModelState.none,
    this.newsDeleteState = MessageDeleteState.none,
    this.offset = 0,
  });
}
