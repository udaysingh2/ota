import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class TicketDetailArgument {
  TicketDetailUserType userType;
  String ticketId;
  String countryId;
  String cityId;
  String ticketDate;
  TicketDetailArgument({
    required this.ticketId,
    required this.countryId,
    required this.cityId,
    required this.userType,
    String? ticketDate,
  }) : ticketDate = ticketDate ??
            Helpers.getYYYYmmddFromDateTime(
                DateTime.now().add(const Duration(days: 1)));
  TicketDetailArgumentDomain toTicketDomainArgument() {
    return TicketDetailArgumentDomain(
        cityId: cityId,
        countryId: countryId,
        ticketId: ticketId,
        ticketDate: ticketDate);
  }

  factory TicketDetailArgument.fromOtaPropertyChannel(String productId,
          String cityId, String countryId, UserType userType) =>
      TicketDetailArgument(
        cityId: cityId,
        countryId: countryId,
        ticketId: productId,
        userType: userType == UserType.loggedInUser
            ? TicketDetailUserType.loggedInUser
            : TicketDetailUserType.guestUser,
      );
  DateTime get ticketDateTime {
    return Helpers().parseDateTime(ticketDate);
  }
}

enum TicketDetailUserType {
  guestUser,
  loggedInUser,
}
