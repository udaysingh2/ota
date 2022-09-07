enum PaymentMethodType { scb, visa, jcb, master, mastercard, unknown, unionpay }

extension PaymentMethodExtensionValue on PaymentMethodType {
  String get value {
    switch (this) {
      case PaymentMethodType.scb:
        return "SCB";
      case PaymentMethodType.visa:
        return "VISA";
      case PaymentMethodType.jcb:
        return "JCB";
      case PaymentMethodType.master:
        return "MASTER";
      case PaymentMethodType.mastercard:
        return "MASTERCARD";
      case PaymentMethodType.unionpay:
        return "UNION_PAY";
      case PaymentMethodType.unknown:
        return "UNKNOWN";
    }
  }
}

extension PaymentMethodExtension on PaymentMethodType {
  static PaymentMethodType getType(String paymentType, String paymentMethod) {
    if (paymentMethod == "PAYWISE") return PaymentMethodType.scb;
    switch (paymentType) {
      case "VISA":
        return PaymentMethodType.visa;
      case "JCB":
        return PaymentMethodType.jcb;
      case "MASTER":
        return PaymentMethodType.master;
      case "MASTERCARD":
        return PaymentMethodType.mastercard;
      case "UNION_PAY":
        return PaymentMethodType.unionpay;
      default:
        return PaymentMethodType.unknown;
    }
  }

  static PaymentMethodType getTypeByCard(String? cardType) {
    if (cardType == null) return PaymentMethodType.scb;
    if (cardType == "") return PaymentMethodType.scb;
    switch (cardType) {
      case "VISA":
        return PaymentMethodType.visa;
      case "JCB":
        return PaymentMethodType.jcb;
      case "MASTER":
        return PaymentMethodType.master;
      case "MASTERCARD":
        return PaymentMethodType.mastercard;
      default:
        return PaymentMethodType.unknown;
    }
  }
}
