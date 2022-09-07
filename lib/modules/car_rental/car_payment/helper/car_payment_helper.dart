import 'package:ota/core/app_config.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_argument_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:provider/provider.dart';

class CarPaymentHelper {
  static List<AddonDataDomain> getCarSupplierList(
      List<ExtraChargeData>? extraCharges, context) {
    List<AddonDataDomain> list = [];
    final value =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    if (extraCharges != null) {
      for (int i = 0; i < extraCharges.length; i++) {
        list.add(
          AddonDataDomain(
              quantity: value
                  .getQuantityForAddOn(extraCharges[i].extraChargeGroup?.id),
              name: extraCharges[i].extraChargeGroup?.name ?? '',
              chargeType: extraCharges[i].chargeType.toString(),
              price: extraCharges[i].price.toString(),
              serviceId: extraCharges[i].id.toString(),
              isCompulsory: extraCharges[i].isCompulsory),
        );
      }
    }
    return list;
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
