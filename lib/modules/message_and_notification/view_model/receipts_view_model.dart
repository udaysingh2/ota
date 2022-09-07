import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';

class ReceiptsViewModel {
  List<MessageDataViewModel> receiptList;
  MessageViewModelState receiptState;
  MessageDeleteState receiptDeleteState;
  bool isInternetPopUpShown = false;
  int offset;

  ReceiptsViewModel({
    required this.receiptList,
    this.receiptState = MessageViewModelState.none,
    this.receiptDeleteState = MessageDeleteState.none,
    this.offset = 0,
  });
}
