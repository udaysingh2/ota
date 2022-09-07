import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/bloc/car_detail_more_info_bloc.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view/widgets/car_detail_more_info_chip_list.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view/widgets/car_detail_more_info_title.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_view_model.dart';
import 'package:ota/modules/hotel/hotel_bookings/view/widgets/hotel_booking_no_result.dart';

class CarDetailMoreInfoScreen extends StatefulWidget {
  const CarDetailMoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarDetailMoreInfoScreen> createState() =>
      _CarDetailMoreInfoScreenState();
}

class _CarDetailMoreInfoScreenState extends State<CarDetailMoreInfoScreen> {
  CarDetailMoreInfoArgumentModel? argument;
  final CarDetailMoreInfoBloc carDetailMoreInfoBloc = CarDetailMoreInfoBloc();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)?.settings.arguments
          as CarDetailMoreInfoArgumentModel;
      if (argument == null) return;
      carDetailMoreInfoBloc.updateFromArgument(argument!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      appBar: _getAppBar(),
    );
  }

  Widget _getBody() {
    return BlocBuilder(
      bloc: carDetailMoreInfoBloc,
      builder: () {
        if (carDetailMoreInfoBloc.state.carDetailInfoViewModelType !=
            CarDetailMoreInfoViewModelType.loaded) return const SizedBox();
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarDetailMoreInfoChipList(
                  chipButtonList: [
                    getTranslated(
                        context, AppLocalizationsStrings.carIncludeLabel),
                    getTranslated(context,
                        AppLocalizationsStrings.carRentalConditionsLabel),
                    getTranslated(
                        context, AppLocalizationsStrings.pickupConditionsLabel),
                  ],
                  onTap: (index) {
                    carDetailMoreInfoBloc.onTappedByIndex(index);
                  },
                  selectedIndex: carDetailMoreInfoBloc.getSelectedIndex(),
                ),
                Expanded(child: _getScrollableData()),
              ],
            ),
          ],
        );
      },
    );
  }

  String _getTitleBasedOnState() {
    switch (carDetailMoreInfoBloc.state.carDetailInfoPickType) {
      case CarDetailMoreInfoPickType.includedInRentalPrice:
        return getTranslated(context, AppLocalizationsStrings.includeLabel);
      case CarDetailMoreInfoPickType.carRentalCondition:
        return getTranslated(
            context, AppLocalizationsStrings.carRentalConditionsLabel);
      case CarDetailMoreInfoPickType.pickUp:
        return getTranslated(
            context, AppLocalizationsStrings.pickupConditionsLabel);
    }
  }

  Widget _getScrollableData() {
    if (carDetailMoreInfoBloc.getHtmlData().isEmpty) {
      return HootelBookingNoResultWithRefresh(
          height: MediaQuery.of(context).size.height - kSize200);
    } else {
      return ListView(children: [
        CarDetailMoreInfoTitle(
          title: _getTitleBasedOnState(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSize24),
          child: Html(data: carDetailMoreInfoBloc.getHtmlData()),
        ),
      ]);
    }
  }

  PreferredSizeWidget _getAppBar() {
    return OtaAppBar(
      title: getTranslated(context, AppLocalizationsStrings.carRentalCondition),
    );
  }
}
