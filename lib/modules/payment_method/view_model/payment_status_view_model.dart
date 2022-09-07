import 'package:flutter/foundation.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';

const int _kRetriesAfterExpiery = 3;

class PaymentMethodStatusViewModel {
  PaymentStatusViewPageState pageState;
  PaymentMethodStatusDataModel? data;
  int retriesAfterExpiery;
  PaymentMethodStatusViewModel({
    required this.pageState,
    this.data,
    this.retriesAfterExpiery = _kRetriesAfterExpiery,
  });
}

class PaymentMethodStatusDataModel {
  PaymentStatusState? paymentStatus;
  String? deeplinkUrl;
  String? bookingUrn;
  bool? isFirstOrder;
  PaymentMethodStatusDataModel({
    this.paymentStatus,
    this.deeplinkUrl,
    this.isFirstOrder,
  });

  PaymentMethodStatusDataModel.mapFromResponse(
      PaymentStatusData data, this.bookingUrn) {
    paymentStatus =
        PaymentStatusStateExtension.getType(data.paymentStatus ?? '');
    deeplinkUrl = data.deeplinkUrl;
    isFirstOrder = data.isFirstOrder ?? false;
  }
}

enum PaymentStatusViewPageState {
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
