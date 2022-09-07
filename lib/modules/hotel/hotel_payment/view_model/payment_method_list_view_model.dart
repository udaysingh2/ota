import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

class PaymentMethodListViewModel {
  List<PaymentMethodViewModel> paymentMethodList;
  PaymentMethodViewState paymentMethodViewState;

  PaymentMethodListViewModel({
    required this.paymentMethodList,
    this.paymentMethodViewState = PaymentMethodViewState.none,
  });
}

class PaymentMethodViewModel {
  String paymentMethodId;
  String nickname;
  PaymentMethodType paymentMethodType; // cardType
  String cardMask;
  String cardRef;
  bool isDefault;

  PaymentMethodViewModel({
    required this.paymentMethodId,
    required this.nickname,
    required this.paymentMethodType,
    required this.cardMask,
    required this.cardRef,
    required this.isDefault,
  });

  factory PaymentMethodViewModel.fromPaymentList(PaymentList paymentModel) {
    return PaymentMethodViewModel(
      paymentMethodId: paymentModel.paymentMethodId ?? '',
      nickname: paymentModel.nickname ?? '',
      paymentMethodType: PaymentMethodExtension.getType(
          paymentModel.cardType ?? '', paymentModel.paymentType ?? ''),
      cardMask: paymentModel.cardMask ?? '',
      cardRef: paymentModel.cardRef ?? '',
      isDefault: paymentModel.defaultMethodFlag ?? false,
    );
  }
  void updatePlayListFromChannel(OtaPaymentModelChannel channel) {
    paymentMethodId =
        (channel.cardType == null) ? "SCBID" : (channel.paymentMethodId ?? "");
    nickname = channel.cardNickName ?? "";
    paymentMethodType = PaymentMethodExtension.getTypeByCard(
      channel.cardType,
    );
    cardMask = channel.cardMark ?? '';
    cardRef = channel.cardRef ?? '';
    isDefault = true;
  }

  factory PaymentMethodViewModel.getSCBModel(bool isDefault) {
    return PaymentMethodViewModel(
      paymentMethodId: 'SCBID',
      nickname: '',
      paymentMethodType: PaymentMethodType.scb,
      cardMask: '',
      cardRef: '',
      isDefault: isDefault,
    );
  }
}

enum PaymentMethodViewState {
  none,
  loading,
  success,
  failure,
}
