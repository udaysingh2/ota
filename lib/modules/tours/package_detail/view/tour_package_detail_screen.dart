import 'package:flutter/material.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/helpers/ota_dialog_helper.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_argument.dart';
import 'package:ota/modules/tours/package_detail/channels/ota_super_app_to_booking_register.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_detail_network_error.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget.dart';
import 'package:ota/modules/tours/package_detail/view_model/tour_package_detail_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_reservation_helper.dart';

const String formNextLine = '\n';
const int roundingOff = 2;
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";

class TourPackageDetailScreen extends StatefulWidget {
  const TourPackageDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TourPackageDetailScreen> createState() =>
      _TourPackageDetailScreenState();
}

class _TourPackageDetailScreenState extends State<TourPackageDetailScreen> {
  final OtaSuperAppToRegisterConfirmBooking
      tourSuperAppToRegisterConfirmBooking =
      OtaSuperAppToRegisterConfirmBooking();
  TourPackageDetailViewModel? tourPackageScreen;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tourSuperAppToRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
  }

  @override
  void dispose() {
    tourSuperAppToRegisterConfirmBooking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tourPackageScreen = ModalRoute.of(context)?.settings.arguments
        as TourPackageDetailViewModel;
    return Scaffold(resizeToAvoidBottomInset: false, body: buildScreen());
  }

  Widget buildScreen() {
    return Column(
      children: [
        OtaAppBar(
          isCenterTitle: true,
          title: getTranslated(
            context,
            AppLocalizationsStrings.packageDetails,
          ),
          actions: const [OtaAppBarAction.backButton],
        ),
        Expanded(
            child: (tourPackageScreen != null && _isNotEmpty()) ||
                    _getCancellationPolicy().isNotEmpty
                ? successWidget()
                : detailErrorWidget()),
      ],
    );
  }

  Widget detailErrorWidget() {
    return PackageDetailErrorWidget(
      height: MediaQuery.of(context).size.height - kSize200,
    );
  }

  Widget successWidget() {
    var value = MediaQuery.of(context).padding.bottom;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: (kSize100 + value)),
          child: _getDescriptionScreen(),
        ),
        _getBottomBar()
      ],
    );
  }

  Widget _getDescriptionScreen() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      children: [
        PackageSectionWidget(
          isHtml: false,
          title:
              getTranslated(context, AppLocalizationsStrings.selectedPackage),
          body: tourPackageScreen!.name,
        ),
        if (tourPackageScreen!.allInclusion != null &&
            tourPackageScreen!.allInclusion!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.includes),
            body: tourPackageScreen!.allInclusion,
          ),
        if (tourPackageScreen!.exclusions != null &&
            tourPackageScreen!.exclusions!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.excludes),
            body: tourPackageScreen!.exclusions,
          ),
        if (tourPackageScreen!.childInfo != null &&
            tourPackageScreen!.childInfo!.description != null &&
            tourPackageScreen!.childInfo!.description!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(
                context, AppLocalizationsStrings.packageCondition),
            body: tourPackageScreen!.childInfo!.description,
          ),
        if (tourPackageScreen!.schedule != null &&
            tourPackageScreen!.schedule!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.itenary),
            body: tourPackageScreen!.schedule,
          ),
        if (_getMeetingPointData().isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.meetingPoint),
            body: _getMeetingPointData(),
          ),
        if ((tourPackageScreen!.cancellationPolicy != null &&
                tourPackageScreen!.cancellationPolicy!.isNotEmpty) ||
            _getCancellationPolicy().isNotEmpty)
          PackageSectionWidget(
            title: getTranslated(
                context, AppLocalizationsStrings.cancelationPolicy),
            body: tourPackageScreen!.cancellationPolicy,
            elementsList: _getCancellationPolicy(),
            isList: true,
          ),
      ],
    );
  }

  List<String> _getCancellationPolicy() {
    if (tourPackageScreen != null && tourPackageScreen!.name != null) {
      return TourReservationHelper.getCancellationPolicy(
          context,
          tourPackageScreen!.cancellationPolicy!,
          AppConfig().configModel.tourCancellationPercent);
    } else {
      return [];
    }
  }

  String _getMeetingPointData() {
    String meetingPointData = "";
    if ((tourPackageScreen!.meetingPoint != null &&
        tourPackageScreen!.meetingPoint!.isNotEmpty)) {
      meetingPointData += tourPackageScreen!.meetingPoint!;
    }
    if ((tourPackageScreen!.shuttle != null &&
        tourPackageScreen!.shuttle!.isNotEmpty)) {
      meetingPointData += tourPackageScreen!.shuttle!;
    }
    return meetingPointData;
  }

  Widget _getBottomBar() {
    CurrencyUtil currencyUtil = CurrencyUtil(
      currency: tourPackageScreen?.currency ?? AppConfig().currency,
      decimalDigits: roundingOff,
    );
    return OtaBottomButtonBar(
      button1: RichText(
          key: const Key("Total_Price"),
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            children: <TextSpan>[
              TextSpan(
                  text: currencyUtil
                      .getFormattedPrice(tourPackageScreen!.adultPrice!),
                  style: AppTheme.kHeading1Medium),
              TextSpan(
                  text: formNextLine +
                      getTranslated(context, AppLocalizationsStrings.startsAt),
                  style: AppTheme.kSmall1)
            ],
          )),
      button2: SizedBox(
        width: kSize120,
        child: OtaTextButton(
          title: getTranslated(context, AppLocalizationsStrings.reserve),
          key: const Key("BookNowButton"),
          onPressed: () {
            LoginModel loginModel = getLoginProvider();
            if (loginModel.userType == UserType.loggedInUser) {
              _onReserveClicked();
            } else {
              OtaDialogHelper.guestUserDialog(
                context,
                getTranslated(
                  context,
                  AppLocalizationsStrings.registerToRobinhoodTourAlert,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _onReserveClicked() {
    if (tourPackageScreen != null) {
      Navigator.pushNamed(
        context,
        AppRoutes.otaBookingCalenderScreen,
        arguments: TourBookingCalendarArgument.fromTourDetailArgument(
            tourPackageScreen!.argument!,
            tourPackageScreen!.rateKey!,
            tourPackageScreen!.currency!,
            tourPackageScreen!.name!,
            tourPackageScreen!.adultPrice!,
            tourPackageScreen!.childPrice!,
            tourPackageScreen!.serviceCategory!,
            tourPackageScreen!.serviceId!,
            tourPackageScreen!.zoneId!,
            tourPackageScreen!.availableSeats!,
            tourPackageScreen!.minimumSeats!,
            tourPackageScreen!.timeOfDay!,
            tourPackageScreen!.startTime!,
            tourPackageScreen!.refCode!),
      );
    }
  }

  void waitForReplyFromSuperApp(RegisterConfirmBookingModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    if (loginModel.userType == UserType.loggedInUser) {
      if (data.existingCust.toString().toLowerCase() == "no") {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(
            context,
            AppLocalizationsStrings.successRegistration,
          ),
          AppColors.kBannerCSuccessColor,
          _kTickIcon,
        );
      }
    }
  }

  bool _isNotEmpty() =>
      tourPackageScreen!.allInclusion != null &&
          tourPackageScreen!.allInclusion!.isNotEmpty ||
      tourPackageScreen!.exclusions != null &&
          tourPackageScreen!.exclusions!.isNotEmpty ||
      tourPackageScreen!.conditions != null &&
          tourPackageScreen!.conditions!.isNotEmpty ||
      tourPackageScreen!.schedule != null &&
          tourPackageScreen!.schedule!.isNotEmpty ||
      _getMeetingPointData().isNotEmpty ||
      tourPackageScreen!.cancellationPolicy != null &&
          tourPackageScreen!.cancellationPolicy!.isNotEmpty;
}
