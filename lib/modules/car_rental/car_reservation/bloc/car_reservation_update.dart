import 'package:flutter/material.dart';

class CarReservationUpdate with ChangeNotifier {
  bool _isSupplierUpdated = false;
  bool _isCarDetailUpdated = false;

  bool get isSupplierUpdated => _isSupplierUpdated;
  bool get isCarDetailUpdated => _isCarDetailUpdated;

  void updateData(bool isUpdate) {
    _isSupplierUpdated = isUpdate;
    _isCarDetailUpdated = isUpdate;
  }

  supplierListUpdated() {
    _isSupplierUpdated = false;
  }

  carDetailUpdated() {
    _isCarDetailUpdated = false;
  }
}
