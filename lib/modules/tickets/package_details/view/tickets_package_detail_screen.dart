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
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';
import 'package:ota/modules/tickets/package_details/view_model/ticket_package_detail_view_model.dart';
import 'package:ota/modules/tickets/reservation/helper/ticket_reservation_helper.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_argument.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/helpers/ota_dialog_helper.dart';
import 'package:ota/modules/tours/package_detail/channels/ota_super_app_to_booking_register.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_detail_network_error.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget.dart';

const String formNextLine = '\n';
const int roundingOff = 2;
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";

class TicketPackageDetailScreen extends StatefulWidget {
  const TicketPackageDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TicketPackageDetailScreen> createState() =>
      _TicketPackageDetailScreenState();
}

class _TicketPackageDetailScreenState extends State<TicketPackageDetailScreen> {
  final OtaSuperAppToRegisterConfirmBooking
      ticketSuperAppToRegisterConfirmBooking =
      OtaSuperAppToRegisterConfirmBooking();
  TicketPackageDetailViewModel? ticketPackageScreen;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ticketSuperAppToRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
  }

  @override
  void dispose() {
    ticketSuperAppToRegisterConfirmBooking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ticketPackageScreen = ModalRoute.of(context)?.settings.arguments
        as TicketPackageDetailViewModel;
    return Scaffold(body: buildScreen());
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
            child: (ticketPackageScreen != null && _isNotEmpty()) ||
                    _getCancellationPolicy().isNotEmpty
                ? successWidget()
                : detailErrorWidget())
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
          title: getTranslated(
            context,
            AppLocalizationsStrings.selectedPackage,
          ),
          body: ticketPackageScreen!.name,
        ),
        if (ticketPackageScreen!.allInclusion != null &&
            ticketPackageScreen!.allInclusion!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(
              context,
              AppLocalizationsStrings.includes,
            ),
            body: ticketPackageScreen!.allInclusion,
          ),
        if (ticketPackageScreen!.exclusions != null &&
            ticketPackageScreen!.exclusions!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(
              context,
              AppLocalizationsStrings.excludes,
            ),
            body: ticketPackageScreen!.exclusions,
          ),
        if (ticketPackageScreen!.childInfo != null &&
            ticketPackageScreen!.childInfo!.description != null &&
            ticketPackageScreen!.childInfo!.description!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(
              context,
              AppLocalizationsStrings.packageCondition,
            ),
            body: ticketPackageScreen!.childInfo!.description,
          ),
        if (_getMeetingPointData().isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.meetingPoint),
            body: _getMeetingPointData(),
          ),
        if ((ticketPackageScreen!.cancellationPolicy != null &&
                ticketPackageScreen!.cancellationPolicy!.isNotEmpty) ||
            _getCancellationPolicy().isNotEmpty)
          PackageSectionWidget(
            title: getTranslated(
                context, AppLocalizationsStrings.cancelationPolicy),
            body: ticketPackageScreen!.cancellationPolicy,
            elementsList: _getCancellationPolicy(),
            isList: true,
          ),
      ],
    );
  }

  List<String> _getCancellationPolicy() {
    if (ticketPackageScreen != null && ticketPackageScreen!.name != null) {
      return TicketReservationHelper.getCancellationPolicy(
          context,
          ticketPackageScreen!.cancellationPolicy!,
          AppConfig().configModel.tourCancellationPercent);
    } else {
      return [];
    }
  }

  String _getMeetingPointData() {
    String meetingPointData = "";
    if ((ticketPackageScreen!.meetingPoint != null &&
        ticketPackageScreen!.meetingPoint!.isNotEmpty)) {
      meetingPointData += ticketPackageScreen!.meetingPoint!;
    }
    if ((ticketPackageScreen!.shuttle != null &&
        ticketPackageScreen!.shuttle!.isNotEmpty)) {
      meetingPointData += ticketPackageScreen!.shuttle!;
    }
    return meetingPointData;
  }

  Widget _getBottomBar() {
    CurrencyUtil currencyUtil = CurrencyUtil(
      currency: ticketPackageScreen?.currency ?? AppConfig().currency,
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
                      .getFormattedPrice(ticketPackageScreen!.totalPrice!),
                  style: AppTheme.kHeading1Medium),
              TextSpan(
                  text: formNextLine +
                      getTranslated(
                          context, AppLocalizationsStrings.startsAtPerTicket),
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
              _onReserveClicked(
                context,
                ticketPackageScreen?.rateKey ?? '',
                ticketPackageScreen?.currency ?? '',
                ticketPackageScreen?.name ?? '',
                ticketPackageScreen!.ticketTypes!,
              );
            } else {
              OtaDialogHelper.guestUserDialog(
                context,
                getTranslated(
                  context,
                  AppLocalizationsStrings.registerToRobinhoodTicketAlert,
                ),
              );
            }
          },
        ),
      ),
    );
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

  void _onReserveClicked(BuildContext context, String rateKey, String currency,
      String name, List<TicketTypeData> ticketTypes) {
    if (ticketPackageScreen != null) {
      Navigator.pushNamed(
        context,
        AppRoutes.ticketBookingCalenderScreen,
        arguments: TicketBookingCalendarArgument.fromTicketDetailArgument(
            argument: ticketPackageScreen!.argument!,
            refCode: ticketPackageScreen!.refCode!,
            rateKey: ticketPackageScreen!.rateKey!,
            ticketTypeData: ticketPackageScreen!.ticketTypes!,
            serviceId: ticketPackageScreen!.serviceId!,
            zoneId: ticketPackageScreen!.zoneId!,
            packageName: ticketPackageScreen!.name!,
            currency: ticketPackageScreen!.currency!,
            timeOfDay: ticketPackageScreen!.timeOfDay!,
            startTime: ticketPackageScreen!.startTime!,
            serviceType: ticketPackageScreen!.serviceType!,
            availableSeats: ticketPackageScreen!.availableSeats!),
      );
    }
  }

  bool _isNotEmpty() =>
      ticketPackageScreen!.allInclusion != null &&
          ticketPackageScreen!.allInclusion!.isNotEmpty ||
      ticketPackageScreen!.exclusions != null &&
          ticketPackageScreen!.exclusions!.isNotEmpty ||
      ticketPackageScreen!.conditions != null &&
          ticketPackageScreen!.conditions!.isNotEmpty ||
      ticketPackageScreen!.cancellationPolicy != null &&
          ticketPackageScreen!.cancellationPolicy!.isNotEmpty;
}
