import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';

TourDetailArgumentDomain getTicketDetailDataArgumentMock() {
  return TourDetailArgumentDomain(
    countryId: "MA05110001",
    cityId: 'MA05110041',
    tourId: 'MA05110042',
    tourDate: '2021-12-26',
  );
}

TicketDetailArgument getTicketDetailArgumentMock() {
  return TicketDetailArgument(
    cityId: "MA05110041",
    userType: TicketDetailUserType.guestUser,
    countryId: 'MA05110001',
    ticketId: 'MA05110042',
  );
}
