import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_cancellation_policy.dart';

import '../../../../../helper.dart';

const String _kConditionalCancellation = "conditional.cancellation";
const String _kFreeCancellation = "policy.cancellation.free";
const String _kNonRefundable = "policy.cancellation.non.refundable";

void main() {
  List<OtaCancellationPolicyListModel> cancellationPolicy = [
    OtaCancellationPolicyListModel(
        cancellationPolicyState: _kConditionalCancellation,
        cancellationDaysDescription:
            "You have to cancel 3 day(s) prior to the service date.",
        cancellationChargeDescription:
            "Otherwise cancellation charge of Full Charge from Grand total will be applied."),
    OtaCancellationPolicyListModel(
        cancellationPolicyState: _kFreeCancellation,
        cancellationDaysDescription:
            "You have to cancel 3 day(s) prior to the service date.",
        cancellationChargeDescription:
            "Otherwise cancellation charge of Full Charge from Grand total will be applied."),
    OtaCancellationPolicyListModel(
        cancellationPolicyState: _kNonRefundable,
        cancellationDaysDescription:
            "You have to cancel 3 day(s) prior to the service date.",
        cancellationChargeDescription:
            "Otherwise cancellation charge of Full Charge from Grand total will be applied."),
  ];

  testWidgets("Hotel booking details cancellation ", (tester) async {
    List<OtaCancellationPolicyListModel> cancellationPolicyViewModel =
        cancellationPolicy;
    Widget widget = getMaterialWrapper(
      HotelBookingDetailsCancellationPolicy(
        cancellationPolicyViewModel: cancellationPolicyViewModel,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
