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
import 'package:ota/modules/tours/description/view/widgets/description_empty_state_view.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_view_model.dart';
import 'package:ota/modules/tours/package_detail/helper/package_detail_helper.dart';

const kAboutTheToursKey = "AboutTheTour";
const kConditionsOfUseKey = "ConditionsOfUse";
const kHowToUseKey = "HowToUse";

class TourDescriptionScreen extends StatefulWidget {
  const TourDescriptionScreen({Key? key}) : super(key: key);

  @override
  TourDescriptionScreenState createState() => TourDescriptionScreenState();
}

class TourDescriptionScreenState extends State<TourDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    TourInformation argument =
        ModalRoute.of(context)?.settings.arguments as TourInformation;

    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.activityDetail),
        isCenterTitle: true,
      ),
      body: OtaChipSegment(
        chipData: [
          ChipData(
              title: AppLocalizationsStrings.activityInformation,
              widget: Expanded(child: _buildAboutTheTour(argument))),
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

  Widget _buildAboutTheTour(TourInformation info) {
    bool isClosingHours =
        (info.openTime?.isEmpty ?? true) || (info.closeTime?.isEmpty ?? true);
    if ((info.description?.isEmpty ?? true) &&
        (info.providerName?.isEmpty ?? true) &&
        isClosingHours) return _buildEmptyWidget();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize16),
      child: SingleChildScrollView(
        key: const PageStorageKey<String>(kAboutTheToursKey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info.description != null)
              Text(
                getTranslated(
                    context, AppLocalizationsStrings.activityInformation),
                style: AppTheme.kHeading1Medium,
              ),
            if (info.description != null)
              const SizedBox(
                height: kSize16,
              ),
            if (info.description != null)
              Html(
                data: info.description,
                style: PackageDetailHelper.getHtmlStyleMap,
              ),
            if (info.description != null)
              const SizedBox(
                height: kSize16,
              ),
            if (info.description != null)
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
          ],
        ),
      ),
    );
  }

  Widget _buildHowToUse(TourInformation info) {
    if ((info.howToUse?.isEmpty ?? true)) return _buildEmptyWidget();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize16),
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

  Widget _buildConditionsOfUse(TourInformation info) {
    if ((info.conditions?.isEmpty ?? true)) return _buildEmptyWidget();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize16),
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
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return const DescriptionEmptyStateView();
  }
}
