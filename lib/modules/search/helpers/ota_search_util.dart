import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';

class OtaSearchUtil {
  late OtaSearchViewArgument _otaSearchViewArgument;
  DateTime _checkInDate = DateTime.now().add(const Duration(days: 1));
  DateTime _checkOutDate = DateTime.now().add(const Duration(days: 2));
  int roomNumber = 1;
  String searchKey;
  String hotelId;
  String cityId;
  String locationId;
  int pageNumber = 1;
  int pageSize = AppConfig().configModel.carouselCardLimit;
  int numAdult = AppConfig().configModel.defaultAdultCount;
  int numChild = AppConfig().configModel.defaultChildCount;
  String defaultSortFilter = AppConfig().configModel.defaultFilterSortCriteria;
  bool searchAvailableApi;
  String? countryId;
  TourAndTicketViewData? tourAndTicketViewData;
  CarViewData? carViewData;
  int kDefaultHours = 10;

  OtaSearchUtil({
    required this.searchAvailableApi,
    required this.hotelId,
    required this.cityId,
    required this.locationId,
    required this.searchKey,
    this.tourAndTicketViewData,
    this.carViewData,
    this.countryId,
  }) {
    _otaSearchViewArgument = _getDefaultArgument();
  }

  void updateFilterArgument(FilterArgument filterArgument,
      {bool isDefault = false}) {
    if (filterArgument.checkOutDate != null) {
      _checkOutDate = Helpers().parseDateTime(filterArgument.checkOutDate!);
    }
    if (filterArgument.checkInDate != null) {
      _checkInDate = Helpers().parseDateTime(filterArgument.checkInDate!);
    }

    if (isDefault) {
      _otaSearchViewArgument.hotelData?.filterData = FilterData(
        sortingMode: defaultSortFilter,
      );
    }

    if (filterArgument.roomList?.isNotEmpty ?? false) {
      numAdult = 0;
      numChild = 0;
      roomNumber = filterArgument.roomList?.length ?? 1;
      _otaSearchViewArgument.hotelData?.bookingData.roomData =
          List.generate(filterArgument.roomList?.length ?? 0, (index) {
        RoomArgument? roomArgument = filterArgument.roomList?.elementAt(index);
        numAdult = numAdult + (roomArgument?.adults ?? 1);
        numChild = numChild + (roomArgument?.childAgeList?.length ?? 0);
        int? childAge1;
        if (((roomArgument?.childAgeList?.length ?? 0) > 0)) {
          childAge1 = roomArgument?.childAgeList?.first ?? 0;
        }
        int? childAge2;
        if (((roomArgument?.childAgeList?.length ?? 0) > 1)) {
          childAge2 = roomArgument?.childAgeList?.last ?? 0;
        }
        return RoomViewData(
          roomType: roomArgument?.bedTypeKey,
          numAdult: roomArgument?.adults ?? 1,
          numChild: roomArgument?.childAgeList?.length ??
              AppConfig().configModel.defaultChildCount,
          childAge1: childAge1,
          childAge2: childAge2,
        );
      });
      _otaSearchViewArgument.hotelData?.bookingData.checkinDate =
          filterArgument.checkInDate!;
      _otaSearchViewArgument.hotelData?.bookingData.checkoutDate =
          filterArgument.checkOutDate!;
      _otaSearchViewArgument.hotelData?.bookingData.numRoom = roomNumber;
    }
  }

  void updatePageNumber(int pageNumber) {
    _otaSearchViewArgument.pageNumber = pageNumber;
  }

  BookingViewData? getBookingData() {
    return _otaSearchViewArgument.hotelData?.bookingData;
  }

  OtaSearchViewArgument getArguments() {
    return _otaSearchViewArgument;
  }

  void updateFilterData(FilterOtaArgumentData? argumentData) {
    _otaSearchViewArgument.hotelData?.filterData = FilterData(
      minPrice: argumentData?.rangeStaringPrice,
      rating: argumentData?.starRating?.toList(),
      sortingMode: argumentData?.getSelectedSortMode(),
      maxPrice: argumentData?.rangeEndingPrice,
      capsulePromotion:
          getCapsulePromotionsList(argumentData?.selectedPromotions),
      sha: argumentData?.selectedSha?.toList(),
    );
  }

  List<PromotionCapsule> getCapsulePromotionsList(
      List<CapsulePromotions>? list) {
    return List.generate(list?.length ?? 0, (index) {
      return PromotionCapsule(
        name: list![index].name,
        code: list[index].code,
      );
    });
  }

  int getPageSize() {
    return int.parse(_otaSearchViewArgument.pageSize);
  }

  String getSearchKey() {
    return searchKey;
  }

  String getDateRoomParseInfo(
      {DateTime? checkInDate,
      DateTime? checkOutDate,
      bool isOtaLandingSearch = false}) {
    if (isOtaLandingSearch) {
      return (checkInDate != null && checkOutDate != null)
          ? checkInDate.day.toString().addTrailingDash() +
              checkOutDate.day.toString().addTrailingSpace() +
              Helpers.getMonthFromDateTime(_checkOutDate)
          : '';
    } else {
      return Helpers.getDMMMFromDateTime(_checkInDate).addTrailingDash() +
          Helpers.getDMMMFromDateTime(_checkOutDate);
    }
  }

  int get totalNumberOfPeople => numAdult + numChild;

  OtaSearchViewArgument _getDefaultArgument() {
    return OtaSearchViewArgument(
        userId: getLoginProvider().userId,
        longitude: 0.0,
        latitude: 0.0,
        pageNumber: pageNumber,
        pageSize: pageSize.toString(),
        searchKey: searchKey,
        hotelData: HotelViewData(
          hotelId: hotelId,
          cityId: cityId,
          locationId: locationId,
          bookingData: BookingViewData(
              checkinDate: Helpers.getYYYYmmddFromDateTime(_checkInDate),
              checkoutDate: Helpers.getYYYYmmddFromDateTime(_checkOutDate),
              roomData: [
                RoomViewData(
                  roomType: AppConfig().configModel.defaultAdultCount ==
                          AppConfig().configModel.bedTypeMaxAdults
                      ? AppConfig().configModel.defaultBedType
                      : null,
                  numAdult: AppConfig().configModel.defaultAdultCount,
                  numChild: AppConfig().configModel.defaultChildCount,
                )
              ],
              numRoom: roomNumber),
        ),
        searchAvailableApi: searchAvailableApi,
        tourAndTicketViewData: tourAndTicketViewData,
        carData: carViewData);
  }
}
