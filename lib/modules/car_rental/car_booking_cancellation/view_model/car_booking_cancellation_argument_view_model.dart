import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

class CarBookingCancellationArgumentViewModel {
  final List<CancellationPolicyModel>? cancellationPolicyList;
  final String cancellationPolicyDescription;
  final String confirmNo;
  final String bookingUrn;
  final DateTime? pickUpDate;

  CarBookingCancellationArgumentViewModel({
    required this.cancellationPolicyList,
    required this.cancellationPolicyDescription,
    required this.confirmNo,
    required this.bookingUrn,
    required this.pickUpDate
  });
}
