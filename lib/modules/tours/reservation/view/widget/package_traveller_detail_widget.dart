import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/reservation/bloc/traveller_detail_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/user_detail_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

const String _kKeyForAdult = 'adult';
const String _kKeyForChild = 'child';

class PackageTravellerDetailWidget extends StatelessWidget {
  final EdgeInsets padding;
  final int adultCount;
  final int childCount;
  final TourRequireInfoViewModel? tourRequireInfoViewModel;
  final TravellerController travellerController;
  final String adultPaxId;
  final String childPaxId;

  const PackageTravellerDetailWidget({
    Key? key,
    this.padding = kPaddingHori24,
    required this.adultCount,
    required this.childCount,
    required this.travellerController,
    required this.adultPaxId,
    required this.childPaxId,
    this.tourRequireInfoViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: travellerController,
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
          getTranslated(context, AppLocalizationsStrings.travellersInformation),
          style: AppTheme.kHeading1Medium),
    );
    screenWidgetList.add(const SizedBox(height: kSize8));
    screenWidgetList.add(
      Text(
        getTranslated(
            context, AppLocalizationsStrings.provideTravellersInformation),
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
      ),
    );
    screenWidgetList.add(const SizedBox(height: kSize16));

    for (int index = 1; index <= adultCount; index++) {
      screenWidgetList.add(
        _buildUserDetailsWidget(
          context: context,
          index: index,
          isForAdult: true,
        ),
      );
      screenWidgetList.add(const SizedBox(height: kSize16));
    }
    for (int index = 1; index <= childCount; index++) {
      screenWidgetList.add(
        _buildUserDetailsWidget(
          context: context,
          index: index,
          isForAdult: false,
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
    required bool isForAdult,
  }) {
    String fullName = '';

    String title = isForAdult
        ? getTranslated(context, AppLocalizationsStrings.adult)
        : getTranslated(context, AppLocalizationsStrings.child);
    fullName = title.addTrailingSpace() + index.toString();
    if (travellerController.state.guestInformationList.containsKey(
        (isForAdult ? _kKeyForAdult : _kKeyForChild) + index.toString())) {
      GuestInformationData? info =
          travellerController.state.guestInformationList[
              (isForAdult ? _kKeyForAdult : _kKeyForChild) + index.toString()];
      if (info != null) {
        String guestName = '${info.guestFirstName} ${info.guestLastName}';
        if (guestName.trim().isNotEmpty) {
          fullName = guestName;
        }
      }
    }
    bool isWarningIconVisible = travellerController.isWarningIconVisible(
      key: (isForAdult ? _kKeyForAdult : _kKeyForChild) + index.toString(),
      tourRequireInfoViewModel: tourRequireInfoViewModel,
    );
    return UserDetailsWidget(
      fullName: fullName,
      isWarningNeeded: isWarningIconVisible,
      onTitleArrowClick: () => _openTourGuestInformationPage(
        context: context,
        index: index,
        isForAdult: isForAdult,
      ),
    );
  }

  void _openTourGuestInformationPage({
    required BuildContext context,
    required int index,
    required bool isForAdult,
  }) async {
    var data = await Navigator.of(context).pushNamed(
      AppRoutes.guestInformationFormPage,
      arguments: GuestInformationArgumentModel(
          guestIndex: index,
          isForAdult: isForAdult,
          isGuestNameRequired: tourRequireInfoViewModel?.guestName,
          isAllnameRequired: tourRequireInfoViewModel?.allName,
          isDateofBirthRequired: tourRequireInfoViewModel?.dateOfBirth,
          isPassportCountryIssueRequired:
              tourRequireInfoViewModel?.passportCountryIssue,
          isPassportCountryRequired: tourRequireInfoViewModel?.passportCountry,
          isPassportIdRequired: tourRequireInfoViewModel?.passportId,
          isPassportValidDateRequired:
              tourRequireInfoViewModel?.passportValidDate,
          isWeightRequired: tourRequireInfoViewModel?.weight,
          updateGuestInfo: travellerController.state.guestInformationList[
              (isForAdult ? _kKeyForAdult : _kKeyForChild) + index.toString()]),
    );
    if (data != null) {
      GuestInformationData info = data as GuestInformationData;
      info.paxId = isForAdult ? adultPaxId : childPaxId;
      travellerController.updateGuestInformation(
        (isForAdult ? _kKeyForAdult : _kKeyForChild) + index.toString(),
        info,
      );
    }
  }
}
