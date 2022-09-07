import 'dart:convert';

class TourTicketPlaylistModelDomain {
  TourTicketPlaylistModelDomain({
    this.getTourAndTicketPlaylist,
  });

  final GetTourAndTicketPlaylist? getTourAndTicketPlaylist;

  factory TourTicketPlaylistModelDomain.fromJson(String str) =>
      TourTicketPlaylistModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourTicketPlaylistModelDomain.fromMap(Map<String, dynamic> json) =>
      TourTicketPlaylistModelDomain(
        getTourAndTicketPlaylist: json["getTourAndTicketPlaylist"] == null
            ? null
            : GetTourAndTicketPlaylist.fromMap(
                json["getTourAndTicketPlaylist"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourAndTicketPlaylist": getTourAndTicketPlaylist == null
            ? null
            : getTourAndTicketPlaylist!.toMap(),
      };
}

class GetTourAndTicketPlaylist {
  GetTourAndTicketPlaylist({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourAndTicketPlaylist.fromJson(String str) =>
      GetTourAndTicketPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourAndTicketPlaylist.fromMap(Map<String, dynamic> json) =>
      GetTourAndTicketPlaylist(
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
    this.playlistId,
    this.playlistName,
    this.listOfPlaylist,
  });
  final String? playlistId;
  final String? playlistName;
  final List<ListOfPlaylist>? listOfPlaylist;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        playlistId: json["playlistId"],
        playlistName: json["playlistName"],
        listOfPlaylist: json["listOfPlaylist"] == null
            ? null
            : List<ListOfPlaylist>.from(
                json["listOfPlaylist"].map((x) => ListOfPlaylist.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "playlistName": playlistName,
        "listOfPlaylist": listOfPlaylist == null
            ? null
            : List<dynamic>.from(listOfPlaylist!.map((x) => x.toMap())),
      };
}

class ListOfPlaylist {
  ListOfPlaylist({
    this.id,
    this.cityId,
    this.countryId,
    this.imageUrl,
    this.name,
    this.locationName,
    this.cityName,
    this.styleName,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.capsulePromotion,
  });

  final String? id;
  final String? cityId;
  final String? countryId;
  final String? imageUrl;
  final String? name;
  final String? locationName;
  final String? cityName;
  final String? styleName;
  final double? startPrice;
  final String? promotionTextLine1;
  final String? promotionTextLine2;
  final List<CapsulePromotion>? capsulePromotion;

  factory ListOfPlaylist.fromJson(String str) =>
      ListOfPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListOfPlaylist.fromMap(Map<String, dynamic> json) => ListOfPlaylist(
        id: json["id"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        locationName: json["locationName"],
        cityName: json["cityName"],
        styleName: json["styleName"],
        startPrice: json["startPrice"]?.toDouble(),
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityId": cityId,
        "countryId": countryId,
        "imageUrl": imageUrl,
        "name": name,
        "locationName": locationName,
        "cityName": cityName,
        "styleName": styleName,
        "startPrice": startPrice,
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
      };
}

class CapsulePromotion {
  CapsulePromotion({
    this.name,
    this.code,
  });

  final String? name;
  final String? code;

  factory CapsulePromotion.fromMap(Map<String, dynamic> json) =>
      CapsulePromotion(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
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
