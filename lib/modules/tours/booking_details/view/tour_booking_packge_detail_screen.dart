import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_package_detail_view_model.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_detail_network_error.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget.dart';
import 'package:ota/modules/tours/reservation/helper/tour_reservation_helper.dart';

class TourBookingPackageDetailScreen extends StatefulWidget {
  const TourBookingPackageDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TourBookingPackageDetailScreen> createState() =>
      _TourBookingPackageDetailScreenState();
}

class _TourBookingPackageDetailScreenState
    extends State<TourBookingPackageDetailScreen> {
  TourBookingPackageDetailViewModel? tourPackageScreen;

  @override
  Widget build(BuildContext context) {
    tourPackageScreen = ModalRoute.of(context)?.settings.arguments
        as TourBookingPackageDetailViewModel;
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
            child: (tourPackageScreen != null &&
                        tourPackageScreen!.isNotEmpty()) ||
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
    return _getDescriptionWidget();
  }

  Widget _getDescriptionWidget() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      children: [
        if (tourPackageScreen!.packageName != null &&
            tourPackageScreen!.packageName!.isNotEmpty)
          PackageSectionWidget(
            isHtml: false,
            title:
                getTranslated(context, AppLocalizationsStrings.selectedPackage),
            body: tourPackageScreen!.packageName!,
          ),
        if (tourPackageScreen!.inclusions != null &&
            tourPackageScreen!.inclusions!.all != null &&
            tourPackageScreen!.inclusions!.all!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.includes),
            body: tourPackageScreen!.inclusions!.all,
          ),
        if (tourPackageScreen!.exclusions != null &&
            tourPackageScreen!.exclusions!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.excludes),
            body: tourPackageScreen!.exclusions,
          ),
        if (tourPackageScreen!.conditions != null &&
            tourPackageScreen!.conditions!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title:
                getTranslated(context, AppLocalizationsStrings.conditionOfUse),
            body: tourPackageScreen!.conditions,
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
        if (tourPackageScreen!.cancellationPolicy != null &&
                tourPackageScreen!.cancellationPolicy!.isNotEmpty ||
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

  List<String> _getCancellationPolicy() {
    if (tourPackageScreen != null && tourPackageScreen!.packageName != null) {
      return TourReservationHelper.getCancellationPolicy(
          context,
          tourPackageScreen!.cancellationPolicy!,
          AppConfig().configModel.tourCancellationPercent);
    } else {
      return [];
    }
  }
}
