import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

class PaymentMethodArgumentModel {
  String paymentMethodId;
  String nickname;
  PaymentMethodType paymentMethodType;
  String cardMask;
  bool isDefault;

  PaymentMethodArgumentModel({
    required this.paymentMethodId,
    required this.nickname,
    required this.paymentMethodType,
    required this.cardMask,
    required this.isDefault,
  });

  factory PaymentMethodArgumentModel.fromViewModel(
      PaymentMethodViewModel viewModel) {
    return PaymentMethodArgumentModel(
      paymentMethodId: viewModel.paymentMethodId,
      nickname: viewModel.nickname,
      paymentMethodType: viewModel.paymentMethodType,
      cardMask: viewModel.cardMask,
      isDefault: viewModel.isDefault,
    );
  }
}
