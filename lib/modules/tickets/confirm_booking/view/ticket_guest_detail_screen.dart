import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/confirm_booking/helper/ticket_confirm_booking_helper.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/guest_detail_widget.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

class TicketGuestDetailScreen extends StatelessWidget {
  const TicketGuestDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int kTicketCounter = 0;
    List<TicketParticipantInfoViewModel> argumentModel = ModalRoute.of(context)
        ?.settings
        .arguments as List<TicketParticipantInfoViewModel>;
    return Scaffold(
      backgroundColor: AppColors.kLight100,
      appBar: OtaAppBar(
        title: getTranslated(
            context, AppLocalizationsStrings.ticketHoldersInformation),
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
          ParticipantInfoViewModel? data =
              TicketConfirmBookingHelper.getFromParticipantInfo(
                  argumentModel.elementAt(index));

          String title =
              getTranslated(context, AppLocalizationsStrings.ticketHolder)
                      .addTrailingSpace() +
                  (++kTicketCounter).toString();
          return GuestDetailsWidget(
            data: data,
            title: title,
          );
        },
      ),
    );
  }
}
