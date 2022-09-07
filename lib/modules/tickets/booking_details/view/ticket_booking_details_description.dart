import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_segment.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/additional_detail_empty_state_view.dart';
import 'package:ota/modules/tours/package_detail/helper/package_detail_helper.dart';

const kAboutTheToursKey = "AboutTheTour";
const kConditionsOfUseKey = "ConditionsOfUse";
const kHowToUseKey = "HowToUse";

class TicketBookingDetailDescriptionScreen extends StatefulWidget {
  const TicketBookingDetailDescriptionScreen({Key? key}) : super(key: key);

  @override
  TicketBookingDetailDescriptionScreenState createState() =>
      TicketBookingDetailDescriptionScreenState();
}

class TicketBookingDetailDescriptionScreenState
    extends State<TicketBookingDetailDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    TicketBookingInformation argument =
        ModalRoute.of(context)?.settings.arguments as TicketBookingInformation;

    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
            context, AppLocalizationsStrings.additionalTicketDetail),
        isCenterTitle: true,
      ),
      body: OtaChipSegment(
        chipData: [
          ChipData(
              title: AppLocalizationsStrings.ticketInformation,
              widget: Expanded(child: _buildAboutTheTicket(argument))),
          ChipData(
              title: AppLocalizationsStrings.termAndCondition,
              flex: 0,
              widget: Expanded(child: _buildConditionsOfUse(argument))),
          ChipData(
              title: AppLocalizationsStrings.howToUse,
              widget: Expanded(child: _buildHowToUse(argument))),
        ],
      ),
    );
  }

  Widget _buildAboutTheTicket(TicketBookingInformation info) {
    bool isClosingHours =
        (info.openTime?.isEmpty ?? true) || (info.closeTime?.isEmpty ?? true);
    if ((info.description?.isEmpty ?? true) &&
        (info.providerName?.isEmpty ?? true) &&
        isClosingHours) return _buildEmptyWidget();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize24),
      child: SingleChildScrollView(
        key: const PageStorageKey<String>(kAboutTheToursKey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info.description != null && info.description!.isNotEmpty)
              Text(
                getTranslated(
                    context, AppLocalizationsStrings.ticketInformation),
                style: AppTheme.kHeading1Medium,
              ),
            if (info.description != null && info.description!.isNotEmpty)
              const SizedBox(
                height: kSize16,
              ),
            if (info.description != null && info.description!.isNotEmpty)
              Html(
                data: info.description,
                style: PackageDetailHelper.getHtmlStyleMap,
              ),
            if (info.description != null && info.description!.isNotEmpty)
              const SizedBox(
                height: kSize16,
              ),
            if (info.description != null && info.description!.isNotEmpty)
              const OtaHorizontalDivider(
                dividerColor: AppColors.kGrey10,
              ),
            if (info.description != null)
              const SizedBox(
                height: kSize16,
              ),
            if (info.providerName != null)
              Text(
                getTranslated(context,
                    AppLocalizationsStrings.serviceProviderInformation),
                style: AppTheme.kHeading1Medium,
              ),
            if (info.providerName != null)
              const SizedBox(
                height: kSize16,
              ),
            if (info.providerName != null)
              Text(
                info.providerName!,
                style: AppTheme.kBodyMedium,
              ),
            if (info.providerName != null)
              const SizedBox(
                height: kSize16,
              ),
            if (info.openTime != null && info.closeTime != null)
              Text(
                getTranslated(context, AppLocalizationsStrings.businessHours),
                style: AppTheme.kBodyRegular,
              ),
            if (info.openTime != null && info.closeTime != null)
              const SizedBox(
                height: kSize4,
              ),
            if (info.openTime != null && info.closeTime != null)
              Text(
                info.openTime!.addTrailingDash() + info.closeTime!,
                style: AppTheme.kBodyRegular,
              ),
            if (info.openTime != null && info.closeTime != null)
              const SizedBox(
                height: kSize16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToUse(TicketBookingInformation info) {
    if ((info.howToUse?.isEmpty ?? true)) return _buildEmptyWidget();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize24),
      child: SingleChildScrollView(
        key: const PageStorageKey<String>(kHowToUseKey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.howToUse),
              style: AppTheme.kHeading1Medium,
            ),
            const SizedBox(
              height: kSize16,
            ),
            Html(
              data: info.howToUse,
              style: PackageDetailHelper.getHtmlStyleMap,
            ),
            const SizedBox(
              height: kSize16,
            ),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionsOfUse(TicketBookingInformation info) {
    if ((info.conditions?.isEmpty ?? true)) return _buildEmptyWidget();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize24),
      child: SingleChildScrollView(
        key: const PageStorageKey<String>(kConditionsOfUseKey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.termAndCondition),
              style: AppTheme.kHeading1Medium,
            ),
            const SizedBox(
              height: kSize16,
            ),
            Html(
              data: info.conditions,
              style: PackageDetailHelper.getHtmlStyleMap,
            ),
            const SizedBox(
              height: kSize16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return const AdditionalDetailsEmptyStateView();
  }
}
