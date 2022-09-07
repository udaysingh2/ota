import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_traveller_detail_controller.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view/widget/user_detail_widget.dart';

class TicketPackageTravellerDetailWidget extends StatelessWidget {
  final EdgeInsets padding;
  final int ticketCount;
  final TicketRequireInfoViewModel? ticketRequireInfoViewModel;
  final TicketTravellerController ticketTravellerController;

  const TicketPackageTravellerDetailWidget({
    Key? key,
    this.padding = kPaddingHori24,
    required this.ticketCount,
    required this.ticketTravellerController,
    this.ticketRequireInfoViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: ticketTravellerController,
      builder: () {
        return Container(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getScreenWidgetList(context),
          ),
        );
      },
    );
  }

  List<Widget> _getScreenWidgetList(BuildContext context) {
    List<Widget> screenWidgetList = [];

    screenWidgetList.add(const SizedBox(height: kSize16));
    screenWidgetList.add(
      Text(
          getTranslated(
              context, AppLocalizationsStrings.ticketHoldersInformation),
          style: AppTheme.kHeading1Medium),
    );
    screenWidgetList.add(const SizedBox(height: kSize8));
    screenWidgetList.add(
      Text(
        getTranslated(
            context, AppLocalizationsStrings.provideTicketHoldersInformation),
        style: AppTheme.kSmallRegular.copyWith(
          color: AppColors.kGrey50,
        ),
      ),
    );
    screenWidgetList.add(const SizedBox(height: kSize16));

    for (int index = 1; index <= ticketCount; index++) {
      screenWidgetList.add(
        _buildUserDetailsWidget(
          context: context,
          index: index,
        ),
      );
      screenWidgetList.add(const SizedBox(height: kSize16));
    }
    screenWidgetList.add(const SizedBox(height: kSize6));
    return screenWidgetList;
  }

  Widget _buildUserDetailsWidget({
    required BuildContext context,
    required int index,
  }) {
    String fullName = '';

    String title = getTranslated(context, AppLocalizationsStrings.ticketHolder);
    fullName = title.addTrailingSpace() + index.toString();
    if (ticketTravellerController.state.ticketGuestInformationList
        .containsKey(index.toString())) {
      TicketGuestInformationData? info = ticketTravellerController
          .state.ticketGuestInformationList[index.toString()];
      if (info != null) {
        String guestName = '${info.guestFirstName} ${info.guestLastName}';
        if (guestName.trim().isNotEmpty) {
          fullName = guestName;
        }
      }
    }
    bool isWarningIconVisible = ticketTravellerController.isWarningIconVisible(
      key: index.toString(),
      ticketRequireInfoViewModel: ticketRequireInfoViewModel,
    );
    return UserDetailsWidget(
      fullName: fullName,
      isWarningNeeded: isWarningIconVisible,
      onTitleArrowClick: () => _openTicketGuestInformationPage(
        context: context,
        index: index,
      ),
    );
  }

  void _openTicketGuestInformationPage({
    required BuildContext context,
    required int index,
  }) async {
    var data = await Navigator.of(context).pushNamed(
      AppRoutes.ticketGuestInformationFormPage,
      arguments: TicketGuestInformationArgumentModel(
          guestIndex: index,
          isGuestNameRequired: ticketRequireInfoViewModel?.guestName,
          isAllNameRequired: ticketRequireInfoViewModel?.allName,
          isDateOfBirthRequired: ticketRequireInfoViewModel?.dateOfBirth,
          isPassportCountryIssueRequired:
              ticketRequireInfoViewModel?.passportCountryIssue,
          isPassportCountryRequired:
              ticketRequireInfoViewModel?.passportCountry,
          isPassportIdRequired: ticketRequireInfoViewModel?.passportId,
          isPassportValidDateRequired:
              ticketRequireInfoViewModel?.passportValidDate,
          isWeightRequired: ticketRequireInfoViewModel?.weight,
          updateGuestInfo: ticketTravellerController
              .state.ticketGuestInformationList[index.toString()]),
    );
    if (data != null) {
      TicketGuestInformationData info = data as TicketGuestInformationData;
      ticketTravellerController.updateGuestInformation(
        index.toString(),
        info,
      );
    }
  }
}
