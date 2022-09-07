import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  test("Hotel Bookings List Test", () {
    Map<String, dynamic> jsonMap = json
        .decode(fixture("message_and_notification/message_model_domain.json"));

    ///For class Message Model Domain
    MessageModelDomain messageModelDomain = MessageModelDomain.fromMap(jsonMap);
    String jsonStringData = messageModelDomain.toJson();
    MessageModelDomain messageJson =
        MessageModelDomain.fromJson(jsonStringData);
    expect(messageJson.notificationInquiry != null, true);

    ///For class get Notification Inquiry
    NotificationInquiry? notificationInquiry =
        messageModelDomain.notificationInquiry;
    String bookingString = notificationInquiry!.toJson();
    NotificationInquiry? bookingJson =
        NotificationInquiry?.fromJson(bookingString);
    expect(bookingJson.data != null, true);

    ///For class Data
    Data? data = messageModelDomain.notificationInquiry?.data;
    String dataString = data!.toJson();
    Data? dataJson = Data?.fromJson(dataString);
    expect(dataJson.messageList != null, true);

    ///For class Message List
    MessageList? messageList =
        messageModelDomain.notificationInquiry?.data?.messageList?[0];
    String messageListStringData = messageList!.toJson();
    MessageList? messageListJson = MessageList?.fromJson(messageListStringData);
    expect(messageListJson.body != null, true);

    ///For class Status
    Status? status = messageModelDomain.notificationInquiry?.status;
    expect(status?.code != null, true);
  });
}
