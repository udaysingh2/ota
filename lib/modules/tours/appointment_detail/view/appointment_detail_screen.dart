import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_map_launcher.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/appointment_detail/view_model/appointment_detail_view_model.dart';
import 'package:ota/modules/tours/package_detail/view/widget/package_section_widget.dart';

const path = "assets/images/icons/location_suggestion.svg";
const _kDefaultCoordinates = "0.0";

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  AppointmentDetailScreenState createState() => AppointmentDetailScreenState();
}

class AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  AppointmentDetailViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = ModalRoute.of(context)?.settings.arguments
        as AppointmentDetailViewModel;
    return Scaffold(
        resizeToAvoidBottomInset: false, body: buildScreen(context));
  }

  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        OtaAppBar(
          isCenterTitle: true,
          title: getTranslated(
            context,
            AppLocalizationsStrings.appointmentDetails,
          ),
          actions: const [OtaAppBarAction.backButton],
        ),
        Expanded(child: _getDescriptionWidget(context)),
      ],
    );
  }

  Widget _getDescriptionWidget(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      children: [
        const SizedBox(height: kSize8),
        if (viewModel!.location != null && viewModel!.location!.isNotEmpty)
          PackageSectionWidget(
            isHtml: false,
            title: getTranslated(
                context, AppLocalizationsStrings.pickupAndDropOffPoint),
            body: viewModel!.location,
          ),
        if (viewModel!.meetingPoint != null &&
            viewModel!.meetingPoint!.isNotEmpty)
          PackageSectionWidget(
            isHtml: true,
            title: getTranslated(context, AppLocalizationsStrings.meetingPoint),
            body: viewModel!.meetingPoint,
          ),
        if (viewModel!.meetingPointLatitude != null &&
            viewModel!.meetingPointLatitude!.isNotEmpty &&
            viewModel!.meetingPointLatitude != _kDefaultCoordinates &&
            viewModel!.meetingPointLongitude != null &&
            viewModel!.meetingPointLongitude!.isNotEmpty &&
            viewModel!.meetingPointLongitude != _kDefaultCoordinates)
          const SizedBox(height: kSize16),
        if (viewModel!.meetingPointLatitude != null &&
            viewModel!.meetingPointLatitude!.isNotEmpty &&
            viewModel!.meetingPointLatitude != _kDefaultCoordinates &&
            viewModel!.meetingPointLongitude != null &&
            viewModel!.meetingPointLongitude!.isNotEmpty &&
            viewModel!.meetingPointLongitude != _kDefaultCoordinates)
          _getViewMapWidget(context)
      ],
    );
  }

  Widget _getViewMapWidget(BuildContext context) {
    return InkWell(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return AppColors.gradient1.createShader(Offset.zero & bounds.size);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              path,
              width: kSize16,
              height: kSize20,
            ),
            const SizedBox(width: kSize4),
            Text(
              getTranslated(context, AppLocalizationsStrings.viewMap),
              style:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kTrueWhite),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      onTap: () => OtaMapLauncher.launchMap(
          latitude: double.parse(viewModel!.meetingPointLatitude!),
          longitude: double.parse(viewModel!.meetingPointLongitude!)),
    );
  }
}
