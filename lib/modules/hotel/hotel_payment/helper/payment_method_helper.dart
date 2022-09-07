import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/payment_method/view_model/payment_method_argument_model.dart';

const _kIconScb = 'assets/images/icons/icon_scb.png';
const _kIconVisa = 'assets/images/icons/icon_visa.svg';
const _kIconJcb = 'assets/images/icons/icon_jcb.png';
const _kIconMastercard = 'assets/images/icons/icon_mastercard.svg';
const _kPlaceholder = 'assets/images/icons/addon_service_placeholder.svg';
const _kIconUnionPay = 'assets/images/icons/icon_union.svg';

class PlaymentMethodHelper {
  static List<PaymentMethodViewModel>? getPaymentMethodViewModelList(
      List<PaymentList>? list) {
    List<PaymentMethodViewModel>? paymentMethodViewModelList;
    if (list == null || list.isEmpty) return paymentMethodViewModelList;

    paymentMethodViewModelList = List<PaymentMethodViewModel>.generate(
      list.length,
      (index) => PaymentMethodViewModel.fromPaymentList(list[index]),
    );
    return paymentMethodViewModelList;
  }

  static List<PaymentMethodArgumentModel>? getPaymentMethodArgumentModelList(
      List<PaymentMethodViewModel>? list) {
    List<PaymentMethodArgumentModel>? paymentMethodArgsModelList;
    if (list == null || list.isEmpty) return paymentMethodArgsModelList;

    paymentMethodArgsModelList = List<PaymentMethodArgumentModel>.generate(
      list.length,
      (index) => PaymentMethodArgumentModel.fromViewModel(list[index]),
    );
    return paymentMethodArgsModelList;
  }

  static Widget buildPaymentMethodImage(PaymentMethodType paymentType) {
    switch (paymentType) {
      case PaymentMethodType.scb:
        return Image.asset(
          _kIconScb,
          fit: BoxFit.cover,
          width: kSize24,
          height: kSize24,
        );
      case PaymentMethodType.visa:
        return SvgPicture.asset(
          _kIconVisa,
          fit: BoxFit.fitWidth,
          height: kSize10,
        );
      case PaymentMethodType.jcb:
        return Image.asset(
          _kIconJcb,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
      case PaymentMethodType.master:
        return SvgPicture.asset(
          _kIconMastercard,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
      case PaymentMethodType.mastercard:
        return SvgPicture.asset(
          _kIconMastercard,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
      case PaymentMethodType.unionpay:
        return SvgPicture.asset(
          _kIconUnionPay,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
      default:
        return SvgPicture.asset(
          _kPlaceholder,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
    }
  }

  static bool isMinAmountValidationFailed(
      {required bool isWalletEnabled,
      double? paidByWallet,
      required double onlinePayableAmount}) {
    double totalAmount = onlinePayableAmount + (paidByWallet ?? 0.0);
    if (totalAmount < AppConfig().configModel.netPriceBoundaryInBaht) {
      return true;
    } else if (isWalletEnabled && onlinePayableAmount == 0.0) {
      return false;
    } else if (onlinePayableAmount >
        AppConfig().configModel.netPriceBoundaryInBaht) {
      return false;
    } else {
      return true;
    }
  }
}
