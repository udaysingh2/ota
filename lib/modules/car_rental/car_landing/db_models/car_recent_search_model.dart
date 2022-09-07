import 'package:hive/hive.dart';
import 'package:ota/core_pack/persistence/hive/boxes.dart';

import '../../../../core/app_config.dart';

part 'car_recent_search_model.g.dart';

@HiveType(typeId: ModelTypeId.carRecentSearchDataModel)
class CarRecentSearchData extends HiveObject {
  CarRecentSearchData(
      {required this.pickupLocationId,
      required this.returnLocationId,
      required this.pickupLocationName,
      required this.returnLocationName,
      required this.pickupDate,
      required this.returnDate,
      required this.pickupTime,
      required this.returnTime,
      required this.age,
      required this.dataSearchType,
      required this.includeDriver,
      required this.isSearchSave,
      required this.languageCode});

  @HiveField(0)
  late String pickupLocationId;

  @HiveField(1)
  late String returnLocationId;

  @HiveField(2)
  late String pickupLocationName;

  @HiveField(3)
  late String returnLocationName;

  @HiveField(4)
  late String pickupDate;

  @HiveField(5)
  late String returnDate;

  @HiveField(6)
  late String pickupTime;

  @HiveField(7)
  late String returnTime;

  @HiveField(8)
  late int age;

  @HiveField(9)
  late String dataSearchType;

  @HiveField(10)
  late bool includeDriver;

  @HiveField(11)
  late bool isSearchSave;

  @HiveField(12)
  late String languageCode;

  factory CarRecentSearchData.fromMap(Map<String, dynamic> json) =>
      CarRecentSearchData(
          pickupLocationId: json["pickupLocationId"],
          returnLocationId: json["returnLocationId"],
          pickupLocationName: json["pickupLocationName"],
          returnLocationName: json["returnLocationName"],
          pickupDate: json["pickupDate"],
          returnDate: json["returnDate"],
          pickupTime: json["pickupTime"],
          returnTime: json["returnTime"],
          age: json["age"],
          dataSearchType: json["dataSearchType"],
          includeDriver: json["includeDriver"],
          isSearchSave: json["isSearchSave"],
          languageCode:
              json["languageCode"] ?? AppConfig().appLocale.languageCode);

  Map<String, dynamic> toMap() => {
        "pickupLocationId": pickupLocationId,
        "returnLocationId": returnLocationId,
        "pickupLocationName": pickupLocationName,
        "returnLocationName": returnLocationName,
        "pickupDate": pickupDate,
        "returnDate": returnDate,
        "pickupTime": pickupTime,
        "returnTime": returnTime,
        "age": age,
        "dataSearchType": dataSearchType,
        "includeDriver": includeDriver,
        "isSearchSave": isSearchSave,
      };
}
