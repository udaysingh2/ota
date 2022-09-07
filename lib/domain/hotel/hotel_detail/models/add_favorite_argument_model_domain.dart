import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';

class AddFavoriteArgumentModelDomain {
  String hotelId;
  String cityId;
  String countryId;
  String hotelName;
  String location;
  String hotelImage;

  AddFavoriteArgumentModelDomain({
    required this.hotelId,
    required this.cityId,
    required this.countryId,
    required this.hotelName,
    required this.location,
    required this.hotelImage,
  });

  factory AddFavoriteArgumentModelDomain.mapArgumentModel(
          HotelDetailArgument? argument, HotelDetailModel? model) =>
      AddFavoriteArgumentModelDomain(
        cityId: argument?.cityId ?? "",
        countryId: argument?.countryCode ?? "",
        hotelId: argument?.hotelId ?? "",
        hotelName: model?.name ?? "",
        hotelImage: model?.coverImageUrl ?? "",
        location: model?.shortAddress ?? "",
      );
}
