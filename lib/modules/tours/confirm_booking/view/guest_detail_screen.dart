import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/guest_detail_widget.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

const String _kAdultKey = 'adult';

class GuestDetailScreen extends StatelessWidget {
  const GuestDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int adultCounter = 0;
    int childCounter = 0;
    List<ParticipantInfoViewModel> argumentModel = ModalRoute.of(context)
        ?.settings
        .arguments as List<ParticipantInfoViewModel>;
    return Scaffold(
      backgroundColor: AppColors.kLight100,
      appBar: OtaAppBar(
        title: getTranslated(
            context, AppLocalizationsStrings.travellersInformation),
        titleColor: AppColors.kGreyScale,
        key: const Key("back_button_icon"),
      ),
      body: ListView.separated(
        itemCount: argumentModel.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: kSize32, vertical: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          );
        },
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          ParticipantInfoViewModel? data = argumentModel.elementAt(index);

          String title = data.paxId == _kAdultKey
              ? getTranslated(context, AppLocalizationsStrings.adult)
                      .addTrailingSpace() +
                  (++adultCounter).toString()
              : getTranslated(context, AppLocalizationsStrings.child)
                      .addTrailingSpace() +
                  (++childCounter).toString();
          return GuestDetailsWidget(
            data: data,
            title: title,
          );
        },
      ),
    );
  }
}
