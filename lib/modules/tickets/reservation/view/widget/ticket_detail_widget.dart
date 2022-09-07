import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_expandable_view_model.dart';

const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";
const int _kMaxLines = 2;

class TicketDetailWidget extends StatelessWidget {
  final String? title;
  final List<TicketHighlight>? facilityMap;
  final List<TicketTypeViewModel> ticketType;
  final TourExpandableController controller;

  const TicketDetailWidget(
      {Key? key,
      this.title,
      this.facilityMap,
      required this.ticketType,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kSize24),
                if (title != null) _getTitle(title!, AppTheme.kHeading1Medium),
                if (title != null) const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      getTranslated(context,
                          AppLocalizationsStrings.reservationTicketDetail),
                      style: AppTheme.kBodyMedium,
                    ),
                    const Spacer(),
                    _getArrowIcon(controller),
                  ],
                ),
                if (controller.state.state == TourExpandableModelState.expanded)
                  _getExpandedView(context),
                const SizedBox(height: kSize24),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              ],
            ),
          );
        });
  }

  Widget _getTitle(String title, TextStyle? textStyle) {
    return Text(
      title,
      style: textStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getArrowIcon(TourExpandableController controller) {
    return OtaIconButton(
      icon: controller.state.state == TourExpandableModelState.expanded
          ? SvgPicture.asset(
              _arrowUp,
              width: kSize20,
              height: kSize20,
            )
          : SvgPicture.asset(
              _arrowDown,
              width: kSize20,
              height: kSize20,
            ),
      onTap: () {
        controller.toggle();
      },
    );
  }

  Widget _getExpandedView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getChildrenList(context),
    );
  }

  List<Widget> _getChildrenList(BuildContext context) {
    List<Widget> childrenList = [];
    if (facilityMap != null) {
      childrenList.add(const SizedBox(height: kSize16));
      childrenList.add(_getFacilityView(context, facilityMap));
      childrenList.add(const SizedBox(height: kSize24));
    }

    if (ticketType.isNotEmpty) {
      if (facilityMap == null) {
        childrenList.add(const SizedBox(height: kSize24));
      }
      childrenList
          .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));
      childrenList.add(const SizedBox(height: kSize24));
      for (TicketTypeViewModel ticket in ticketType) {
        if (ticket.noOfTickets > 0) {
          childrenList.add(_getTicketPrice(context, ticket.name, ticket.price));
          childrenList.add(const SizedBox(height: kSize8));
        }
      }
    }

    return childrenList;
  }

  Widget _getFacilityView(
      BuildContext context, List<TicketHighlight>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(
      BuildContext context, List<TicketHighlight>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (TicketHighlight facility in facilityMap) {
        if (facility.value != null) {
          facilityList.add(_getService(facility.key!, facility.value!));
          facilityList.add(const SizedBox(
            height: kSize6,
          ));
        }
      }
    }
    return facilityList;
  }

  Widget _getService(String assetId, String offerId) {
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }

  Widget _getTicketPrice(
      BuildContext context, String ticketName, double ticketPrice) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            ticketName,
            style: AppTheme.kBodyRegular,
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLines,
          ),
        ),
        Expanded(child: _getPrice(context, ticketPrice)),
      ],
    );
  }

  Widget _getPrice(BuildContext context, num? price) {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Align(
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: currencyUtil
                    .getFormattedPrice(price ?? 0)
                    .addTrailingSpace(),
                style: AppTheme.kBodyMedium.copyWith(fontFamily: kFontFamily)),
            TextSpan(
                text: getTranslated(
                        context, AppLocalizationsStrings.perTicketPriceLabel)
                    .addLeadingSlash(),
                style: AppTheme.kBodyRegular.copyWith(
                    fontFamily: kFontFamily, color: AppColors.kGrey50))
          ]),
        ));
  }
}
