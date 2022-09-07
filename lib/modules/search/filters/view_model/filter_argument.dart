import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';

class FilterArgument {
  String? currencyCode;
  String? name;
  String? locationId;
  String? countryCode;
  String? hotelId;
  String? cityId;
  String? checkInDate;
  String? checkOutDate;
  List<RoomArgument>? roomList;
  String? pushScreen;
  Function(FilterArgument filterArgument)? onUpdated;
  FilterArgument({
    this.currencyCode,
    this.name,
    this.locationId,
    this.countryCode,
    this.hotelId,
    this.cityId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomList,
    this.pushScreen = AppRoutes.hotelDetail,
    this.onUpdated,
  });

  factory FilterArgument.fromHotelDetailArguments(HotelDetailArgument? argument,
      {String? pushScreen, String? name, String? locationId}) {
    return FilterArgument(
      locationId: locationId,
      name: name,
      countryCode: argument?.countryCode,
      currencyCode: argument?.currencyCode,
      hotelId: argument?.hotelId,
      checkInDate: argument?.checkInDate,
      checkOutDate: argument?.checkOutDate,
      cityId: argument?.cityId,
      roomList: FilterHelper.getRoomArgumentList(argument?.rooms),
      pushScreen: pushScreen ?? AppRoutes.hotelDetail,
    );
  }

  factory FilterArgument.fromFilterViewModel(FilterViewModel model,
      {String? name,
      String? locationId,
      String? cityId,
      String? countryCode,
      String? hotelId}) {
    return FilterArgument(
        checkInDate: Helpers.getYYYYmmddFromDateTime(model.checkInDate),
        checkOutDate: Helpers.getYYYYmmddFromDateTime(model.checkOutDate),
        roomList: FilterHelper.getRoomArgumentListFromModel(model.roomList),
        cityId: cityId,
        hotelId: hotelId,
        name: name,
        countryCode: countryCode,
        locationId: locationId);
  }
}

class RoomArgument {
  int? adults;
  List<int>? childAgeList;
  String? bedTypeKey;
  RoomArgument({
    required this.adults,
    required this.childAgeList,
    this.bedTypeKey,
  });
}
