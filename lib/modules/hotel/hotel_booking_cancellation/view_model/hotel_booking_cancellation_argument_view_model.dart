import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';

class HotelBookingCancellationArgumentViewModel {
  List<OtaCancellationPolicyListModel>? cancellationPolicyList;
  final String confirmNo;
  final String bookingUrn;
  final String bookingStatus;
  HotelBookingCancellationArgumentViewModel({
    this.cancellationPolicyList,
    required this.confirmNo,
    required this.bookingUrn,
    required this.bookingStatus,
  });
}
