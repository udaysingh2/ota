import 'package:flutter/material.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/landing/view/widgets/service_card_widget.dart';
import 'package:ota/modules/landing/view/widgets/wrapped_grid_view_widget.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_view_model.dart';

const double _kServiceCardPadding = 75;

class OtaServiceCardGridView extends StatelessWidget {
  final List<OtaResrvationServiceCardViewModel> serviceCardList;
  final bool isTour;
  const OtaServiceCardGridView(
      {Key? key, required this.serviceCardList, required this.isTour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getserviceCards(serviceCardList.length, context);
  }

  Widget _getserviceCards(final int countServiceCards, BuildContext context) {
    return WrappedGridView(
        listOfWidget: _getChildrenServiceCards(countServiceCards, context));
  }

  List<Widget> _getChildrenServiceCards(
      final int countServiceCards, BuildContext context) {
    List<Widget> childrenServiceCard = [];
    for (var item = 0; item < countServiceCards; item++) {
      if (serviceCardList[item].serviceText != null) {
        childrenServiceCard.add(ServiceCardWidget(
          footerText: serviceCardList[item].title ?? '',
          headerText: serviceCardList[item].serviceText!,
          imageUrl: isLarge(item, countServiceCards)
              ? (serviceCardList[item].largeImageUrl) ?? ''
              : (serviceCardList[item].imageUrl) ?? '',
          width: isLarge(item, countServiceCards)
              ? double.infinity
              : (MediaQuery.of(context).size.width - _kServiceCardPadding) / 3,
          onTap: () => _onServiceCardClicked(serviceCardList[item], context),
          serviceViewModelService: ServiceViewModelServiceExtension.fromString(
              serviceCardList[item].service),
        ));
      }
    }
    return childrenServiceCard;
  }

  void _onServiceCardClicked(
      OtaResrvationServiceCardViewModel serviceCrad, BuildContext context) {
    switch (serviceCrad.service) {
      case OtaServiceType.hotel:
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.hotelSearchScreen,
            (Route<dynamic> route) =>
                route.settings.name == AppRoutes.landingPage);
        break;
      case OtaServiceType.insurance:
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.insuranceLandingScreen, (Route<dynamic> route) {
          return route.settings.name == AppRoutes.landingPage;
        }, arguments: isTour ? OtaServiceType.activity : OtaServiceType.ticket);
        break;
      case OtaServiceType.carRental:
        if (OtaServiceEnabledHelper.isCarEnabled()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.carLandingScreen,
              (Route<dynamic> route) =>
                  route.settings.name == AppRoutes.landingPage);
        }
        break;
      default:
        return;
    }
  }

  bool isLarge(int currentIndex, int count) {
    if (count % 3 == 1) {
      if (currentIndex == count - 1) {
        return true;
      }
    }
    return false;
  }
}
