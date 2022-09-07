import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class TourDetailArgument {
  TourDetailUserType userType;
  String tourId;
  String countryId;
  String cityId;
  String tourDate;
  TourDetailArgument({
    required this.tourId,
    required this.countryId,
    required this.cityId,
    required this.userType,
    String? tourDate,
  }) : tourDate = tourDate ??
            Helpers.getYYYYmmddFromDateTime(
                DateTime.now().add(const Duration(days: 1)));
  TourDetailArgumentDomain toTourDomainArgument() {
    return TourDetailArgumentDomain(
      cityId: cityId,
      countryId: countryId,
      tourId: tourId,
      tourDate: tourDate,
    );
  }

  factory TourDetailArgument.fromOtaPropertyChannel(String productId,
          String cityId, String countryId, UserType userType) =>
      TourDetailArgument(
        cityId: cityId,
        countryId: countryId,
        tourId: productId,
        userType: userType == UserType.loggedInUser
            ? TourDetailUserType.loggedInUser
            : TourDetailUserType.guestUser,
      );

  DateTime get tourDateTime {
    return Helpers().parseDateTime(tourDate);
  }
}

enum TourDetailUserType {
  guestUser,
  loggedInUser,
}
