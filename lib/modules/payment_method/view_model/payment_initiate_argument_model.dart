import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';

class PaymentMethodInitiateArgument {
  String bookingUrn;
  String newbookingUrn;
  String currency;
  OtaCountDownController? otaCountDownController;
  ScreenToPayment? screenComingFrom;
  CarPaymentArgumentModel? carPaymentArgumentModel;
  List<PaymentMethodTypeArgument>? paymentDetails;

  PaymentMethodInitiateArgument({
    required this.otaCountDownController,
    required this.bookingUrn,
    required this.newbookingUrn,
    required this.currency,
    this.screenComingFrom,
    this.carPaymentArgumentModel,
    this.paymentDetails,
  });

  PaymentInitiateArgumentModelDomain toPaymentInitiateArgumentModelDomain() {
    return PaymentInitiateArgumentModelDomain(
      bookingUrn: bookingUrn,
      currency: currency,
      payment: List.generate(
        paymentDetails?.length ?? 0,
        (index) => paymentDetails![index].toPaymentMethodTypeArgumentDomain(),
      ),
    );
  }
}

class PaymentMethodReInitiateArgument {
  String bookingUrn;
  OtaCountDownController otaCountDownController;

  PaymentMethodReInitiateArgument({
    required this.otaCountDownController,
    required this.bookingUrn,
  });
}

class PaymentMethodTypeArgument {
  String paymentMethod;
  double price;
  String? paymentType;
  String? cardType;
  String? paymentMethodId;
  String? cardRef;

  PaymentMethodTypeArgument({
    required this.paymentMethod,
    required this.price,
    this.paymentType,
    this.cardType,
    this.paymentMethodId,
    this.cardRef,
  });

  PaymentMethodTypeArgumentDomain toPaymentMethodTypeArgumentDomain() {
    return PaymentMethodTypeArgumentDomain(
      paymentMethod: paymentMethod,
      cardType: cardType,
      price: price,
      cardRef: cardRef,
      paymentMethodId: paymentMethodId,
      paymentType: paymentType,
    );
  }
}

enum ScreenToPayment { hotel, carRental }
