import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/landing/view/widgets/service_card_widget.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_view_model.dart';

const double _kServiceCardWidth = 100;
const double _listHeight = 164;

class OtaServiceCardListView extends StatelessWidget {
  final List<OtaResrvationServiceCardViewModel> serviceCardList;
  final String serviceType;
  final EdgeInsets padding;
  const OtaServiceCardListView({
    Key? key,
    required this.serviceCardList,
    required this.serviceType,
    this.padding = const EdgeInsets.symmetric(horizontal: kSize24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getserviceCards(serviceCardList.length, context);
  }

  Widget _getserviceCards(final int countServiceCards, BuildContext context) {
    return SizedBox(
      height: _listHeight,
      child: ListView.separated(
        padding: padding,
        itemBuilder: (BuildContext context, int index) {
          return ServiceCardWidget(
            footerText: serviceCardList[index].title ?? '',
            headerText: serviceCardList[index].serviceText!,
            imageUrl: serviceCardList[index].imageUrl ?? '',
            width: _kServiceCardWidth,
            onTap: () => _onServiceCardClicked(serviceCardList[index], context),
            serviceViewModelService:
                ServiceViewModelServiceExtension.fromString(
                    serviceCardList[index].service),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: kSize16),
        itemCount: serviceCardList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }

  void _onServiceCardClicked(
      OtaResrvationServiceCardViewModel serviceCrad, BuildContext context) {
    switch (serviceCrad.service) {
      case OtaServiceType.hotel:
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.hotelLandingScreen,
            (Route<dynamic> route) =>
                route.settings.name == AppRoutes.landingPage);
        break;
      case OtaServiceType.insurance:
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.insuranceLandingScreen, (Route<dynamic> route) {
          return route.settings.name == AppRoutes.landingPage;
        }, arguments: serviceType);
        break;
      case OtaServiceType.carRental:
        if (OtaServiceEnabledHelper.isCarEnabled()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.carLandingScreen,
              (Route<dynamic> route) =>
                  route.settings.name == AppRoutes.landingPage);
        }
        break;
      case OtaServiceType.tour:
        if (OtaServiceEnabledHelper.isTourEnabled()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.toursLandingScreen,
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
