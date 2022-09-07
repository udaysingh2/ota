import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

class CarLandingChips extends StatelessWidget {
  final CarLandingBloc carLandingBloc;

  const CarLandingChips({
    Key? key,
    required this.carLandingBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSize40,
      padding: const EdgeInsets.fromLTRB(kSize16, kSize8, kSize24, kSize8),
      child: Row(
        children: [
          OtaChipButton(
            title: getTranslated(context, AppLocalizationsStrings.carRent),
            isSelected:
                carLandingBloc.state.carRentalType == CarRentalType.carRent,
            onPressed: () =>
                carLandingBloc.updateCarRentalType(CarRentalType.carRent),
          ),
          const SizedBox(width: kSize8),
          OtaChipButton(
            title: getTranslated(
                context, AppLocalizationsStrings.carRentWithDriver),
            isSelected: carLandingBloc.state.carRentalType ==
                CarRentalType.carRentWithDriver,
            onPressed: () => carLandingBloc
                .updateCarRentalType(CarRentalType.carRentWithDriver),
          )
        ],
      ),
    );
  }
}
