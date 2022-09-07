import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';

class PaymentInitiateArgumentModelDomain {
  final String bookingUrn;
  final String currency;
  final List<PaymentMethodTypeArgumentDomain> payment;
  PaymentInitiateArgumentModelDomain({
    required this.bookingUrn,
    required this.currency,
    required this.payment,
  });
  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn.addQuote(),
        "currency": currency.addQuote(),
        "payment": payment.map((x) => x.toMap()).toList()
      };
}

class PaymentMethodTypeArgumentDomain {
  final String paymentMethod;
  final String? cardType;
  final double price;
  final String? paymentMethodId;
  final String? paymentType;
  final String? cardRef;
  PaymentMethodTypeArgumentDomain({
    required this.paymentMethod,
    this.cardType,
    required this.price,
    this.cardRef,
    this.paymentMethodId,
    this.paymentType,
  });

  Map<String, dynamic> toMap() => {
        "paymentMethod": paymentMethod.addQuote(),
        if (cardType != null) "cardType": cardType!.addQuote(),
        "price": price,
        if (cardRef != null) "cardRef": cardRef!.addQuote(),
        if (paymentMethodId != null)
          "paymentMethodId": paymentMethodId!.addQuote(),
        if (paymentType != null) "paymentType": paymentType!.addQuote(),
      };
}
