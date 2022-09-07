import 'package:ota/common/utils/helper.dart';

import 'addon_service_argument_model.dart';

const int _kDefaultServiceQuantity = 1;

class AddonServiceViewModel {
  String title;
  String description;
  double price;
  DateTime checkInDate;
  DateTime checkOutDate;
  int quantity;
  int noOfAdults;
  DateTime? serviceSelectedDate;
  List<DateTime> preselectedDates;
  String uniqueId;
  String imageUrl;
  bool isFlight;

  AddonServiceViewModel({
    required this.title,
    required this.description,
    required this.price,
    required this.checkInDate,
    required this.checkOutDate,
    required this.noOfAdults,
    this.quantity = _kDefaultServiceQuantity,
    this.serviceSelectedDate,
    required this.preselectedDates,
    required this.uniqueId,
    required this.imageUrl,
    required this.isFlight,
  });

  factory AddonServiceViewModel.mapAddOnServiceArgument(
      AddonServiceCalendarArgument argument) {
    DateTime parsedCheckInDate = Helpers().parseDateTime(argument.checkInDate);
    return AddonServiceViewModel(
      checkInDate: parsedCheckInDate,
      checkOutDate: Helpers().parseDateTime(argument.checkOutDate),
      title: argument.title,
      description: argument.description,
      price: argument.price,
      noOfAdults: argument.noOfAdults,
      serviceSelectedDate: argument.serviceSelectedDate == null
          ? null
          : Helpers().parseDateTime(argument.serviceSelectedDate!),
      preselectedDates:
          argument.preselectedDates == null ? [] : argument.preselectedDates!,
      quantity: argument.quantity == null ? 1 : argument.quantity!,
      uniqueId: argument.uniqueId,
      imageUrl: argument.imageUrl,
      isFlight: argument.isFlight,
    );
  }
}
