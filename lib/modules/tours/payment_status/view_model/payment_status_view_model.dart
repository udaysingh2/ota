import 'package:flutter/foundation.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';

class PaymentStatusViewModel {
  PaymentStatusModel? paymentStatusModel;
  PaymentStatusViewState paymentStatusViewState;

  PaymentStatusViewModel({
    this.paymentStatusViewState = PaymentStatusViewState.initial,
    this.paymentStatusModel,
  });
}

class PaymentStatusModel {
  PaymentStatusState? paymentStatus;
  String? deeplinkUrl;
  String? bookingUrn;
  bool? isFirstOrder;

  PaymentStatusModel({
    this.paymentStatus,
    this.deeplinkUrl,
    this.isFirstOrder,
  });

  PaymentStatusModel.mapFromResponse(
      PaymentStatusData paymentStatusModel, this.bookingUrn) {
    paymentStatus = PaymentStatusStateExtension.getType(
        paymentStatusModel.paymentStatus ?? '');
    deeplinkUrl = paymentStatusModel.deeplinkUrl;
    isFirstOrder = paymentStatusModel.isFirstOrder ?? false;
  }
}

enum PaymentStatusViewState {
  initial,
  loading,
  failure,
  failurePromo3000,
  success,
  deeplinkFound,
  internetFailure,
}

enum PaymentStatusState { inProgress, success, failed }

extension PaymentStatusStateExtensionValue on PaymentStatusState {
  String get value {
    return describeEnum(this).toUpperCase();
  }
}

extension PaymentStatusStateExtension on PaymentStatusState {
  static PaymentStatusState getType(String paymentStatus) {
    return PaymentStatusState.values.firstWhere(
        (e) => describeEnum(e).toUpperCase() == paymentStatus,
        orElse: () => PaymentStatusState.inProgress);
  }
}
