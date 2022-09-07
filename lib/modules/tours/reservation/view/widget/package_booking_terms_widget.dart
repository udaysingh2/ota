import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";

class PackageBookingTermsWidget extends StatelessWidget {
  final EdgeInsets padding;
  final String? cancellationStatus;
  final List<String>? bookingTermsList;
  final bool showDivider;
  final OtaCancellationPolicyController controller;

  const PackageBookingTermsWidget({
    Key? key,
    this.padding = kPaddingHori24,
    this.cancellationStatus,
    this.bookingTermsList,
    this.showDivider = true,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Container(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kSize24),
                Row(
                  children: [
                    Text(
                      getTranslated(context,
                          AppLocalizationsStrings.tourCancellationPolicy),
                      style: AppTheme.kHeading1Medium,
                    ),
                    const Spacer(),
                    _getArrowIcon(controller),
                  ],
                ),
                if (controller.state.state ==
                    OtaCancellationPolicyListModelState.expanded)
                  _getExpandedView(context),
                const SizedBox(height: kSize24),
                if (showDivider)
                  const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              ],
            ),
          );
        });
  }

  String getCancellationStatus(BuildContext context, String statusKey) {
    return statusKey;
  }

  Widget getTermsList(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          String bookingText = bookingTermsList![index];
          return (bookingTermsList!.length > 1 && index == 0)
              ? Text(
                  bookingText,
                  style:
                      AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
                )
              : Text(
                  bookingText,
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                );
        },
        itemCount: bookingTermsList!.length);
  }

  Widget _getArrowIcon(OtaCancellationPolicyController controller) {
    return OtaIconButton(
      icon:
          controller.state.state == OtaCancellationPolicyListModelState.expanded
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
      children: [
        const SizedBox(height: kSize16),
        if (bookingTermsList != null && bookingTermsList!.isNotEmpty)
          getTermsList(context),
      ],
    );
  }
}
