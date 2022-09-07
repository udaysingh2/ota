import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

TourDetailArgumentDomain getTourDetailDataArgumentMock() {
  return TourDetailArgumentDomain(
    countryId: "MA05110001",
    cityId: 'MA05110041',
    tourId: 'MA05110042',
    tourDate: '2021-12-26',
  );
}

TourDetailArgument getTourDetailArgumentMock() {
  return TourDetailArgument(
    cityId: "MA05110041",
    userType: TourDetailUserType.guestUser,
    countryId: 'MA05110001',
    tourId: 'MA05110042',
    tourDate: '2021-12-26',
  );
}
