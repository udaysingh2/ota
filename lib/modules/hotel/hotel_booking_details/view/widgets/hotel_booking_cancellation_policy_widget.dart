import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxlines = 1;
const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";

@Deprecated('Use instead [OtaCancellationPolicyListWidget]')
class HotelBookingCancellationPolicyListWidget extends StatelessWidget {
  final List<OtaCancellationPolicyListModel>? cancellationPolicyModel;

  final OtaCancellationPolicyController controller =
      OtaCancellationPolicyController();
  HotelBookingCancellationPolicyListWidget({
    Key? key,
    this.cancellationPolicyModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getHeading(context),
                  _getTrailing(controller),
                ],
              ),
              const SizedBox(
                height: kSize10,
              ),
              _getCancellationConditions(),
              //_getCondition(context),
            ],
          );
        });
  }

  Widget _getTrailing(OtaCancellationPolicyController controller) {
    return InkWell(
      borderRadius: BorderRadius.circular(kSize40),
      onTap: () {
        controller.toggle();
      },
      child: Padding(
        padding: const EdgeInsets.all(kSize8),
        child: Ink(
          height: kSize20,
          width: kSize20,
          child: controller.state.state ==
                  OtaCancellationPolicyListModelState.expanded
              ? SvgPicture.asset(_arrowUp)
              : SvgPicture.asset(_arrowDown),
        ),
      ),
    );
  }

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.cancellationPolicy),
      style: AppTheme.kHeading1Medium,
      maxLines: _kMaxlines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getCancellationConditions() {
    List<OtaCancellationPolicyListModel> cancellationPolicy =
        cancellationPolicyModel ?? [];

    return Offstage(
      offstage: controller.state.state ==
          OtaCancellationPolicyListModelState.collapsed,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cancellationPolicy.length,
        itemBuilder: (BuildContext context, int index) {
          String cancellationDaysDescription =
              cancellationPolicy[index].cancellationDaysDescription ?? '';
          String cancellationChargeDescription =
              cancellationPolicy[index].cancellationChargeDescription ?? '';
          return cancellationDaysDescription.isEmpty &&
                  cancellationChargeDescription.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cancellationDaysDescription,
                        style: AppTheme.kBodyRegular
                            .copyWith(color: AppColors.kGrey50)),
                    Text(cancellationChargeDescription,
                        style: AppTheme.kSmallRegular
                            .copyWith(color: AppColors.kGrey50)),
                    const SizedBox(
                      height: kSize20,
                    ),
                  ],
                );
        },
      ),
    );
  }

  /// As per CR the text line of 4% cancellation charge is moved out of MVP 1 scope.
  /// Hence related code is commented out

  // Widget _getCondition(BuildContext context) {
  //   return Text(
  //     getTranslated(context, AppLocalizationsStrings.cancellationFeeText1)
  //             .addTrailingSpace() +
  //         Helpers.getNumberWithPercentage(
  //             AppConfig().configModel.processingFee) +
  //         getTranslated(context, AppLocalizationsStrings.cancellationFeeText2)
  //             .addLeadingSpace(),
  //     style: AppTheme.kBody.copyWith(color: AppColors.kGrey50),
  //   );
  // }
}
