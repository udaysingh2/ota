class TicketDetailArgumentDomain {
  String ticketId;
  String countryId;
  String cityId;
  String? ticketDate;
  TicketDetailArgumentDomain(
      {required this.ticketId,
      required this.countryId,
      required this.cityId,
      required this.ticketDate});

  factory TicketDetailArgumentDomain.from(
      String cityId, String countryId, String ticketId, String date) {
    return TicketDetailArgumentDomain(
      cityId: cityId,
      countryId: countryId,
      ticketId: ticketId,
      ticketDate: date,
    );
  }
}
