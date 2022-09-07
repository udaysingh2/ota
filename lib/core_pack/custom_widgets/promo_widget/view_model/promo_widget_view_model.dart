import 'package:flutter/material.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';

class PromoWidgetViewModel with ChangeNotifier {
  PromoWidgetState promoState;
  PromoCodeData? data;
  PromoWidgetViewModel({
    this.promoState = PromoWidgetState.noPromo,
    this.data,
  });

  void setPromoWidgetViewModelData(PromoWidgetViewModel promoWidgetViewModel) {
    promoState = promoWidgetViewModel.promoState;
    data = promoWidgetViewModel.data;
  }
}

enum PromoWidgetState { appliedPromo, noPromo }
