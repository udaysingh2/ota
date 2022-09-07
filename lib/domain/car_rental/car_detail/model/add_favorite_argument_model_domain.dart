import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_view_model.dart';

import '../../../../modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';

class AddFavoriteArgumentModelDomain {
  String id;
  String supplierId;
  String name;
  String location;
  String image;
  String pickupLocationId;
  String dropLocationId;
  String pickupDate;
  String dropDate;
  String rentalType;
  String? pickupCounter;
  String? returnCounter;
  int age;

  AddFavoriteArgumentModelDomain(
      {required this.id,
      required this.supplierId,
      required this.name,
      required this.location,
      required this.image,
      required this.pickupLocationId,
      required this.dropLocationId,
      required this.pickupDate,
      required this.dropDate,
      required this.rentalType,
      required this.age,
      this.pickupCounter,
      this.returnCounter});

  factory AddFavoriteArgumentModelDomain.mapArgumentModel(
          CarDetailArgumentModel? argument, CarDetailInfoModel? model) =>
      AddFavoriteArgumentModelDomain(
          name: '${model?.carInfo?.brand}${" "}${model?.carInfo?.name}',
          pickupLocationId: argument?.pickupLocationId ?? '',
          age: argument?.age ?? 0,
          dropDate: Helpers.getyyyyMMddTHHmmssFromDateTime(model?.toDate),
          pickupDate: Helpers.getyyyyMMddTHHmmssFromDateTime(model?.fromDate),
          location: model?.carDetail?.pickupCounter?.cityName ?? '',
          rentalType: argument?.rentalType ?? '',
          dropLocationId: argument?.returnLocationId ?? '',
          supplierId: argument?.supplierId ?? '',
          image: model?.carInfo?.images?.full ?? '',
          id: argument?.carId ?? '',
          pickupCounter: argument?.pickupCounter ?? "0",
          returnCounter: argument?.returnCounter ?? '0');
}
