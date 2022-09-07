import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';

class MessageDataViewModel {
  int messageId;
  String? bookingUrn;
  String? confirmationNumber;
  String subject;
  String? body;
  String category;
  String? promotionType;
  bool readFlag;
  String? createDate;
  String? deepUrl;
  String? bookingStatus;

  MessageDataViewModel({
    required this.messageId,
    this.bookingUrn,
    this.confirmationNumber,
    required this.subject,
    this.body,
    required this.category,
    this.readFlag = false,
    this.createDate,
    this.promotionType,
    this.deepUrl,
    this.bookingStatus,
  });

  factory MessageDataViewModel.formModel(MessageList messageList) {
    return MessageDataViewModel(
      messageId: messageList.messageId ?? 0,
      subject: messageList.subject ?? "",
      category: messageList.category ?? "",
      body: messageList.body,
      deepUrl: messageList.deeplink,
      promotionType: messageList.promotionType,
      createDate: messageList.createDate,
      readFlag: messageList.readFlag ?? true,
      bookingUrn: messageList.bookingUrn,
      confirmationNumber: messageList.confirmationNo,
      bookingStatus: messageList.bookingStatus,
    );
  }
}

enum MessageViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  internetFailure,
  internetFailureRefresh
}

enum MessageDeleteState {
  none,
  deleteSuccessful,
  deleteUnsuccessful,
  internetFailure,
}
