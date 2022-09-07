// To parse this JSON data, do
//
//     final serviceCard = serviceCardFromMap(jsonString);

import 'dart:convert';

class ServiceCardModelDomain {
  ServiceCardModelDomain({
    this.getTourServiceCards,
  });

  final GetTourServiceCards? getTourServiceCards;

  factory ServiceCardModelDomain.fromJson(String str) =>
      ServiceCardModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceCardModelDomain.fromMap(Map<String, dynamic> json) =>
      ServiceCardModelDomain(
        getTourServiceCards: json["getTourServiceCards"] == null
            ? null
            : GetTourServiceCards.fromMap(json["getTourServiceCards"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourServiceCards":
            getTourServiceCards == null ? null : getTourServiceCards!.toMap(),
      };
}

class GetTourServiceCards {
  GetTourServiceCards({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourServiceCards.fromJson(String str) =>
      GetTourServiceCards.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourServiceCards.fromMap(Map<String, dynamic> json) =>
      GetTourServiceCards(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class Data {
  Data({
    this.ticket,
    this.tour,
  });

  final Ticket? ticket;
  final Ticket? tour;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        ticket: json["ticket"] == null ? null : Ticket.fromMap(json["ticket"]),
        tour: json["tour"] == null ? null : Ticket.fromMap(json["tour"]),
      );

  Map<String, dynamic> toMap() => {
        "ticket": ticket == null ? null : ticket!.toMap(),
        "tour": tour == null ? null : tour!.toMap(),
      };
}

class Ticket {
  Ticket({
    this.imageTitle,
    this.imageUrl,
    this.title,
    this.description,
    this.deeplinkUrl,
    this.sortSeq,
  });

  final String? imageTitle;
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? deeplinkUrl;
  final int? sortSeq;

  factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        imageTitle: json["imageTitle"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        description: json["description"],
        deeplinkUrl: json["deeplinkUrl"],
        sortSeq: json["sortSeq"],
      );

  Map<String, dynamic> toMap() => {
        "imageTitle": imageTitle,
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
        "deeplinkUrl": deeplinkUrl,
        "sortSeq": sortSeq,
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

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

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
