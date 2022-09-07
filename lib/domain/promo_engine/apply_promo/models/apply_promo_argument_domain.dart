import 'package:ota/common/utils/string_extension.dart';

class ApplyPromoArgumentDomain {
  final String bookingUrn;
  final PromotionDetailsModel promotionDetailsModel;

  ApplyPromoArgumentDomain({
    required this.bookingUrn,
    required this.promotionDetailsModel,
  });

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn.surroundWithDoubleQuote(),
        "promotion": promotionDetailsModel.toMap(),
      };
}

class PromotionDetailsModel {
  final int promotionId;
  final String promotionName;
  final String shortDescription;
  final String merchantId;
  final double discount;
  final double? maximumDiscount;
  final String discountType;
  final String discountFor;
  final String promotionLink;
  final String promotionType;
  final String? iconUrl;
  final String voucherCode;
  final String promotionCode;
  final DateTime startDate;
  final DateTime endDate;
  final String applicationKey;

  PromotionDetailsModel({
    required this.promotionId,
    required this.promotionName,
    required this.shortDescription,
    required this.merchantId,
    required this.discount,
    this.maximumDiscount,
    required this.discountType,
    required this.discountFor,
    required this.promotionLink,
    required this.promotionType,
    this.iconUrl,
    required this.voucherCode,
    required this.promotionCode,
    required this.startDate,
    required this.endDate,
    required this.applicationKey,
  });

  Map<String, dynamic> toMap() => {
        "promotionId": promotionId,
        "promotionName": promotionName.surroundWithDoubleQuote(),
        "shortDescription": shortDescription.surroundWithDoubleQuote(),
        "merchantId": merchantId.surroundWithDoubleQuote(),
        "discount": discount,
        "maximumDiscount": maximumDiscount,
        "discountType": discountType.surroundWithDoubleQuote(),
        "discountFor": discountFor.surroundWithDoubleQuote(),
        "promotionLink": promotionLink.surroundWithDoubleQuote(),
        "promotionType": promotionType.surroundWithDoubleQuote(),
        "iconUrl": iconUrl?.surroundWithDoubleQuote(),
        "voucherCode": voucherCode.surroundWithDoubleQuote(),
        "promotionCode": promotionCode.surroundWithDoubleQuote(),
        "startDate": startDate.toString().surroundWithDoubleQuote(),
        "endDate": endDate.toString().surroundWithDoubleQuote(),
        "applicationKey": applicationKey.surroundWithDoubleQuote(),
      };
}
