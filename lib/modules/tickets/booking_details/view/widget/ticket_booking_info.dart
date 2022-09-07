import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';

class TicketBookingInfo extends StatelessWidget {
  final List<TicketBookingDetailsTicketTypeInfo>? ticketType;
  const TicketBookingInfo({
    Key? key,
    required this.ticketType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kSize12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _getChildrenList(context),
      ),
    );
  }

  List<Widget> _getChildrenList(BuildContext context) {
    List<Widget> childrenList = [];

    childrenList.add(const SizedBox(height: kSize4));
    childrenList
        .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));
    childrenList.add(const SizedBox(height: kSize16));
    if (ticketType != null) {
      childrenList.add(_getTicketTypeView(context, ticketType));
      childrenList.add(const SizedBox(height: kSize24));
    }
    childrenList
        .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    return childrenList;
  }

  Widget _getTicketTypeView(BuildContext context,
      List<TicketBookingDetailsTicketTypeInfo>? ticketType) {
    return Column(
      children: _getTicketTypeList(context, ticketType),
    );
  }

  List<Widget> _getTicketTypeList(BuildContext context,
      List<TicketBookingDetailsTicketTypeInfo>? facilityMap) {
    List<Widget> facilityList = [];
    if (ticketType != null) {
      for (TicketBookingDetailsTicketTypeInfo ticket in ticketType!) {
        if (ticket.noOfTickets > 0) {
          facilityList.add(_getTicketPrice(context, ticket.name, ticket.price));
          facilityList.add(const SizedBox(
            height: kSize8,
          ));
        }
      }
    }
    return facilityList;
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
          ),
        ),
        _getPrice(context, ticketPrice),
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
                text: getTranslated(context, AppLocalizationsStrings.pax)
                    .addLeadingSlash(),
                style: AppTheme.kBodyRegularGrey50
                    .copyWith(fontFamily: kFontFamily))
          ]),
        ));
  }
}
