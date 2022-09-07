import 'package:flutter/material.dart';

class HotelDetailStatus with ChangeNotifier {
  void updateHotelDetailView() {
    notifyListeners();
  }
}
