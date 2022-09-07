class AddonServiceCalendarArgument {
  String title;
  String description;
  double price;
  String checkInDate;
  String checkOutDate;
  int noOfAdults;
  String?
      serviceSelectedDate; //Selected date for edit purpose, chekin date by defaut in new add on case
  List<DateTime>? preselectedDates; //Already Selected same service dates
  int? quantity;
  String currency;
  String uniqueId;
  String imageUrl;
  bool isFlight;

  AddonServiceCalendarArgument({
    required this.title,
    required this.description,
    required this.price,
    required this.checkInDate,
    required this.checkOutDate,
    required this.noOfAdults,
    this.serviceSelectedDate,
    this.preselectedDates,
    this.quantity,
    required this.currency,
    required this.uniqueId,
    required this.imageUrl,
    required this.isFlight,
  });
}
