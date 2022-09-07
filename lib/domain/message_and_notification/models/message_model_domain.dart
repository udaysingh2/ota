import 'dart:convert';

class MessageModelDomain {
  MessageModelDomain({
    this.notificationInquiry,
  });

  final NotificationInquiry? notificationInquiry;

  factory MessageModelDomain.fromJson(String str) =>
      MessageModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModelDomain.fromMap(Map<String, dynamic> json) =>
      MessageModelDomain(
        notificationInquiry: json["notificationInquiry"] == null
            ? null
            : NotificationInquiry.fromMap(json["notificationInquiry"]),
      );

  Map<String, dynamic> toMap() => {
        "notificationInquiry": notificationInquiry?.toMap(),
      };
}

class NotificationInquiry {
  NotificationInquiry({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory NotificationInquiry.fromJson(String str) =>
      NotificationInquiry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationInquiry.fromMap(Map<String, dynamic> json) =>
      NotificationInquiry(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class Data {
  Data({
    this.messageList,
  });

  final List<MessageList>? messageList;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        messageList: json["messageList"] == null
            ? null
            : List<MessageList>.from(
                json["messageList"].map((x) => MessageList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "messageList": messageList == null
            ? null
            : List<dynamic>.from(messageList!.map((x) => x.toMap())),
      };
}

class MessageList {
  MessageList({
    this.messageId,
    this.bookingUrn,
    this.confirmationNo,
    this.bookingStatus,
    this.subject,
    this.body,
    this.category,
    this.promotionType,
    this.readFlag,
    this.createDate,
    this.deeplink,
    this.priority,
  });

  final int? messageId;
  final String? bookingUrn;
  final String? confirmationNo;
  final String? bookingStatus;
  final String? subject;
  final String? body;
  final String? category;
  final String? promotionType;
  final bool? readFlag;
  final String? createDate;
  final String? deeplink;
  final String? priority;

  factory MessageList.fromJson(String str) =>
      MessageList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageList.fromMap(Map<String, dynamic> json) => MessageList(
        messageId: json["messageId"],
        bookingUrn: json["bookingUrn"],
        confirmationNo: json["confirmationNo"],
        bookingStatus: json["bookingStatus"],
        subject: json["subject"],
        body: json["body"],
        category: json["category"],
        promotionType: json["promotionType"],
        readFlag: json["readFlag"],
        createDate: json["createDate"],
        deeplink: json["deeplink"],
        priority: json["priority"],
      );

  Map<String, dynamic> toMap() => {
        "messageId": messageId,
        "bookingUrn": bookingUrn,
        "confirmationNo": confirmationNo,
        "bookingStatus": bookingStatus,
        "subject": subject,
        "body": body,
        "category": category,
        "promotionType": promotionType,
        "readFlag": readFlag,
        "createDate": createDate,
        "deeplink": deeplink,
        "priority": priority,
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final String? description;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
      };
}
