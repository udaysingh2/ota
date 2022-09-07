import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/modules/payment_method/view_model/payment_status_view_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  Map<String, dynamic> jsonMap =
      json.decode(fixture("payment_status/payment_status.json"));
  printDebug('jsonMap --> $jsonMap');
  PaymentStatusModelDomain paymentStatusModelDomain =
      PaymentStatusModelDomain.fromMap(jsonMap);
  printDebug(
      'paymentStatusModelDomain --> ${paymentStatusModelDomain.paymentStatus}');
  PaymentStatusData paymentStatusData =
      paymentStatusModelDomain.paymentStatus!.data!;

  test("Payment Status View Model Test with initial state", () {
    PaymentMethodStatusViewModel paymentMethodStatusViewModel =
        PaymentMethodStatusViewModel(
            data: PaymentMethodStatusDataModel(),
            pageState: PaymentStatusViewPageState.initial);

    expect(paymentMethodStatusViewModel.pageState,
        PaymentStatusViewPageState.initial);
  });
  test("Payment Status View Model Test with Failure state", () {
    PaymentMethodStatusDataModel paymentMethodStatusDataModel =
        PaymentMethodStatusDataModel.mapFromResponse(paymentStatusData, '');
    expect(paymentMethodStatusDataModel.paymentStatus,
        PaymentStatusStateExtension.getType('FAILED'));
  });
  test("Payment Status View Model Test with Success state", () {
    PaymentMethodStatusViewModel paymentMethodStatusViewModel =
        PaymentMethodStatusViewModel(
            data: PaymentMethodStatusDataModel(
              paymentStatus: PaymentStatusStateExtension.getType('SUCCESS'),
            ),
            pageState: PaymentStatusViewPageState.success);

    expect(paymentMethodStatusViewModel.pageState,
        PaymentStatusViewPageState.success);
    expect(paymentMethodStatusViewModel.data?.paymentStatus,
        PaymentStatusStateExtension.getType('SUCCESS'));
  });
}
