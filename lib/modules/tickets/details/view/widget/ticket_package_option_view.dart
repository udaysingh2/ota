import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_select_parameter.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';
import 'package:ota/modules/tickets/package_details/view_model/ticket_package_detail_view_model.dart';

const int roundingOff = 2;
const int _kMaxLine = 1;
const String _kServiceType = 'Ticket';

class TicketPackageOptionView extends StatefulWidget {
  final TicketPackage ticketPackage;
  final Function()? onReservePress;
  const TicketPackageOptionView(
      {Key? key, required this.ticketPackage, required this.onReservePress})
      : super(key: key);

  @override
  TicketPackageOptionViewState createState() => TicketPackageOptionViewState();
}

class TicketPackageOptionViewState extends State<TicketPackageOptionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(kSize16, kSize10, kSize16, kSize16),
        decoration: const BoxDecoration(
          borderRadius: kBorderRad12,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
            vertical: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getCardTopBar(),
            _getCardMiddleBar(),
            const SizedBox(
              height: kSize12,
            ),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
            const SizedBox(
              height: kSize16,
            ),
            _getCardBottomBar()
          ],
        ),
      ),
    );
  }

  Widget _getCardTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: kSize6),
            child: Text(
              widget.ticketPackage.packageDetail!.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: roundingOff,
              style: AppTheme.kBodyMedium,
            ),
          ),
        ),
        OtaNextButton(
            key: const Key("OtaNextButton"),
            onPress: () {
              _onNextButtonClicked();
            }),
      ],
    );
  }

  void _onNextButtonClicked() {
    Navigator.pushNamed(context, AppRoutes.ticketPackageDetailScreen,
        arguments: widget.ticketPackage.packageScreen);
  }

  Widget _getCardMiddleBar() {
    List<TicketHighlight> highlights =
        widget.ticketPackage.packageDetail?.highlights ?? [];
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: kSize4),
        shrinkWrap: true,
        itemCount: highlights.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (highlights[index].key != null &&
              highlights[index].value != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: kSize4),
              child: _getService(
                highlights[index].value!,
                highlights[index].key!,
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget _getService(String offerId, String assetId) {
    String imageName = FacilityHelper.getAssetName(assetId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          imageName,
          width: kSize20,
          height: kSize20,
          color: AppColors.kGrey70,
        ),
        const SizedBox(
          width: kSize6,
        ),
        Expanded(
          child: Text(
            offerId,
            maxLines: _kMaxLine,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }

  Widget _getCardBottomBar() {
    CurrencyUtil currencyUtil = CurrencyUtil(
      currency:
          widget.ticketPackage.packageDetail?.currency ?? AppConfig().currency,
      decimalDigits: roundingOff,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: AppTheme.kBodyMedium.copyWith(
                  fontFamily: kFontFamily,
                ),
                children: [
                  TextSpan(
                      text: currencyUtil
                          .getFormattedPrice(
                              widget.ticketPackage.packageDetail!.totalPrice!)
                          .addTrailingSpace(),
                      style: AppTheme.kBodyMedium),
                  TextSpan(
                      text: getTranslated(context,
                              AppLocalizationsStrings.perTicketPriceLabel)
                          .addLeadingSlash(),
                      style: AppTheme.kBodyRegular
                          .copyWith(color: AppColors.kGrey50))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: kSize120,
          child: OtaTextButton(
            key: const Key("OtaTextButton"),
            title: getTranslated(context, AppLocalizationsStrings.reserve),
            child: Text(
              getTranslated(context, AppLocalizationsStrings.reserve),
              style: AppTheme.kButton3,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              if (widget.onReservePress != null)  {widget.onReservePress!();
              _getReserveClickedFirebase();
              FirebaseHelper.stopCapturingEvent(FirebaseEvent.activitySelect);
              }
            },
          ),
        )
      ],
    );
  }

  void _getReserveClickedFirebase() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityService,
        value: _kServiceType);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityPackageName,
        value: widget.ticketPackage.packageDetail?.name);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityPricePerPerson,
        value: widget.ticketPackage.packageDetail?.totalPrice);
  }
}
