import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_package_detail_view_model.dart';
import 'package:ota/modules/tickets/reservation/helper/ticket_reservation_helper.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_detail_network_error.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget.dart';

class TicketBookingPackageDetailScreen extends StatefulWidget {
  const TicketBookingPackageDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TicketBookingPackageDetailScreen> createState() =>
      _TicketBookingPackageDetailScreenState();
}

class _TicketBookingPackageDetailScreenState
    extends State<TicketBookingPackageDetailScreen> {
  TicketBookingPackageDetailViewModel? ticketBookingPackageDetailViewModel;

  @override
  Widget build(BuildContext context) {
    ticketBookingPackageDetailViewModel = ModalRoute.of(context)
        ?.settings
        .arguments as TicketBookingPackageDetailViewModel;
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
            child: (ticketBookingPackageDetailViewModel != null &&
                        ticketBookingPackageDetailViewModel!.isNotEmpty()) ||
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
    return _getDescriptionWidget();
  }

  Widget _getDescriptionWidget() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      children: [
        if (ticketBookingPackageDetailViewModel!.packageName != null &&
            ticketBookingPackageDetailViewModel!.packageName!.isNotEmpty)
          PackageSectionWidget(
            isHtml: false,
            title:
                getTranslated(context, AppLocalizationsStrings.selectedPackage),
            body: ticketBookingPackageDetailViewModel!.packageName!,
          ),
        if (ticketBookingPackageDetailViewModel!.inclusions != null &&
            ticketBookingPackageDetailViewModel!.inclusions!.all != null &&
            ticketBookingPackageDetailViewModel!.inclusions!.all!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(
              context,
              AppLocalizationsStrings.includes,
            ),
            body: ticketBookingPackageDetailViewModel!.inclusions!.all,
          ),
        if (ticketBookingPackageDetailViewModel!.exclusions != null &&
            ticketBookingPackageDetailViewModel!.exclusions!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(
              context,
              AppLocalizationsStrings.excludes,
            ),
            body: ticketBookingPackageDetailViewModel!.exclusions,
          ),
        if (ticketBookingPackageDetailViewModel!.conditions != null &&
            ticketBookingPackageDetailViewModel!.conditions!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title:
                getTranslated(context, AppLocalizationsStrings.conditionOfUse),
            body: ticketBookingPackageDetailViewModel!.conditions,
          ),
        if (_getMeetingPointData().isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.meetingPoint),
            body: _getMeetingPointData(),
          ),
        if (ticketBookingPackageDetailViewModel!.cancellationPolicy != null &&
                ticketBookingPackageDetailViewModel!
                    .cancellationPolicy!.isNotEmpty ||
            _getCancellationPolicy().isNotEmpty)
          PackageSectionWidget(
            title: getTranslated(
                context, AppLocalizationsStrings.cancelationPolicy),
            body: ticketBookingPackageDetailViewModel!.cancellationPolicy,
            elementsList: _getCancellationPolicy(),
            isList: true,
          ),
      ],
    );
  }

  String _getMeetingPointData() {
    String meetingPointData = "";
    if ((ticketBookingPackageDetailViewModel!.meetingPoint != null &&
        ticketBookingPackageDetailViewModel!.meetingPoint!.isNotEmpty)) {
      meetingPointData += ticketBookingPackageDetailViewModel!.meetingPoint!;
    }
    if ((ticketBookingPackageDetailViewModel!.shuttle != null &&
        ticketBookingPackageDetailViewModel!.shuttle!.isNotEmpty)) {
      meetingPointData += ticketBookingPackageDetailViewModel!.shuttle!;
    }
    return meetingPointData;
  }

  List<String> _getCancellationPolicy() {
    if (ticketBookingPackageDetailViewModel != null &&
        ticketBookingPackageDetailViewModel!.packageName != null) {
      return TicketReservationHelper.getCancellationPolicy(
          context,
          ticketBookingPackageDetailViewModel!.cancellationPolicy!,
          AppConfig().configModel.tourCancellationPercent);
    } else {
      return [];
    }
  }
}
