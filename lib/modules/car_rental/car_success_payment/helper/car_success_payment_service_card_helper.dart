import 'package:flutter/material.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/car_success_payment_service_card_view_model.dart';

const String _kHotelService = "CARRENTAL";

class CarSuccessPaymentServiceCardHelper {
  static Map<String, String> getServicesMap() {
    final String serviceCards =
        AppConfig().configModel.paymentConfirmationRecommendations;
    final List<String> serviceCardList = serviceCards.split(',');
    Map<String, String> map = {for (var item in serviceCardList) item: item};
    return map;
  }

  static List<CarSuccessPaymentServiceCardViewModel> getServiceCardList(
      BuildContext context) {
    List<CarSuccessPaymentServiceCardViewModel> serviceViewModelList = [];
    Map<String, String> map = getServicesMap();

    List<ServiceViewModel>? serviceViewModel =
        Provider.of<LandingPageViewModel>(context).serviceList;

    if (serviceViewModel.isNotEmpty) {
      for (int i = 0; i < serviceViewModel.length; i++) {
        if (serviceViewModel.elementAt(i).service == _kHotelService) {
          continue;
        } else if (map[serviceViewModel.elementAt(i).service] == null) {
          continue;
        } else {
          serviceViewModelList.add(CarSuccessPaymentServiceCardViewModel(
            title: serviceViewModel.elementAt(i).title,
            description: serviceViewModel.elementAt(i).description,
            serviceText: serviceViewModel.elementAt(i).serviceText,
            deeplinkUrl: serviceViewModel.elementAt(i).deepLinkUrl,
            imageUrl: serviceViewModel.elementAt(i).imageUrl,
            largeImageUrl: serviceViewModel.elementAt(i).largeImageUrl,
            service: serviceViewModel.elementAt(i).service,
            serviceBackgroundUrl:
                serviceViewModel.elementAt(i).serviceBackgroundUrl,
          ));
        }
      }
    }
    return serviceViewModelList;
  }
}
