import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';

const int _kMaxLines = 1;
const String _kTicketMultiplySign = 'x';

class TicketParticipantCountWidget extends StatelessWidget {
  final List<TicketBookingDetailsTicketTypeInfo>? ticketList;
  final EdgeInsets padding;
  const TicketParticipantCountWidget(
      {Key? key, required this.ticketList, this.padding = kPaddingHori24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getTicketInfo(context),
    );
  }

  List<Widget> getTicketInfo(BuildContext context) {
    List<Widget> ticketWidgetList = [];

    ticketWidgetList.add(const SizedBox(height: kSize24));
    ticketWidgetList.add(_getHeading(context));

    ticketWidgetList.add(const SizedBox(height: kSize8));
    for (TicketBookingDetailsTicketTypeInfo ticket in ticketList!) {
      if (ticket.noOfTickets > 0) {
        ticketWidgetList.add(_getTicketWidget(ticket.name, ticket.noOfTickets));
        ticketWidgetList.add(const SizedBox(height: kSize8));
      }
    }

    ticketWidgetList.add(const SizedBox(height: kSize24));
    ticketWidgetList
        .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    return ticketWidgetList;
  }

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.noOfTickets),
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getTicketWidget(String name, int noOfDays) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: AppTheme.kBodyRegular,
            maxLines: _kMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return AppColors.gradient1.createShader(Offset.zero & bounds.size);
          },
          child: Text(
            _kTicketMultiplySign + noOfDays.toString(),
            style: AppTheme.kBodyRegular.copyWith(color: AppColors.kTrueWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
