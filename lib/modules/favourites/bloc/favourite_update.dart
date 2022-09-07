import 'package:flutter/material.dart';

class FavouriteUpdate with ChangeNotifier {
  bool _isUpdated = false;
  bool get isUpdated => _isUpdated;
  void updateFavourite(bool isUpdate) {
    _isUpdated = isUpdate;
    notifyListeners();
  }
}
