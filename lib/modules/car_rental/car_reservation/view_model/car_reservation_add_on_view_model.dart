import 'package:flutter/material.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

class CarReservationAddOnViewModel extends ChangeNotifier {
  Map addOnServiceMap = {};

  int getQuantityForAddOn(int? addOnId) {
    if (addOnServiceMap.containsKey(addOnId)) {
      return addOnServiceMap[addOnId];
    } else {
      return 0;
    }
  }

  int getQuantityForMandatoryAddOn(int? addOnId) {
    if (addOnServiceMap.containsKey(addOnId)) {
      return addOnServiceMap[addOnId];
    } else {
      return 1;
    }
  }

  bool isAddOnAvailable(int? addOnId) {
    return addOnServiceMap.containsKey(addOnId);
  }

  void putAddOn(int? addOnId, int quantity) {
    if (addOnServiceMap.containsKey(addOnId)) {
      addOnServiceMap.update(addOnId, (value) => quantity);
    } else {
      addOnServiceMap.putIfAbsent(addOnId, () => quantity);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void deleteAddOn(int? addOnId) {
    addOnServiceMap.remove(addOnId);
    notifyListeners();
  }

  bool shouldDeleteAddOn(int? addOnId, quantity) {
    if (addOnServiceMap.containsKey(addOnId)) {
      return quantity == 0 ? true : false;
    } else {
      return false;
    }
  }

  getTotalPrice(
    List<ExtraChargeData> extraCharges,
    double? totalPrice,
    int? numOfDays,
  ) {
    double price = 0;
    for (int i = 0; i <= extraCharges.length - 1; i++) {
      extraCharges[i].chargeType == 0
          ? price = price +
              ((extraCharges[i].addonPriceToDisplay!) *
                  getQuantityForAddOn(extraCharges[i].extraChargeGroup?.id) *
                  numOfDays!)
          : price = price +
              ((extraCharges[i].addonPriceToDisplay!) *
                  getQuantityForAddOn(extraCharges[i].extraChargeGroup?.id));
    }
    return totalPrice! + price;
  }

  void resetValues() {
    addOnServiceMap = {};
    notifyListeners();
  }
}
