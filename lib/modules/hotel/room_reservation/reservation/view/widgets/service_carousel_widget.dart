import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_add_on_service_card.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

const double _kContainerHeight = 148;

class ServiceCarouselWidget extends StatelessWidget {
  final List<AddonsModel> serviceList;
  final Function(int) onItemClicked;
  const ServiceCarouselWidget(
      {Key? key, required this.serviceList, required this.onItemClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kSize24),
          child: _getTitleBar(context),
        ),
        const SizedBox(
          height: kSize16,
        ),
        SizedBox(
          height: _kContainerHeight,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: serviceList.length,
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            itemBuilder: (context, index) {
              return OtaAddOnServiceCard(
                hotelServiceName: serviceList.elementAt(index).serviceName,
                price: double.tryParse(serviceList.elementAt(index).cost) ?? 0,
                imageUrl: serviceList.elementAt(index).imageUrl,
                onPress: () {
                  onItemClicked(index);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: kSize8,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getTitleBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslated(context, AppLocalizationsStrings.recommendedServices),
          style: AppTheme.kHeading1Medium,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
