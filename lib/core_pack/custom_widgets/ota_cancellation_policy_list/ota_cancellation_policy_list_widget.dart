import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxLines = 1;
const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";

class OtaCancellationPolicyListWidget extends StatelessWidget {
  final List<OtaCancellationPolicyListModel>? cancellationPolicyModel;

  final OtaCancellationPolicyController controller =
      OtaCancellationPolicyController();

  OtaCancellationPolicyListWidget({
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
              _getCancellationConditions(context),
              Offstage(
                  offstage: controller.state.state ==
                      OtaCancellationPolicyListModelState.collapsed,
                  child: _getCancellationPolicyLine(context).isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: kSize20),
                          child: Text(_getCancellationPolicyLine(context),
                              style: AppTheme.kSmallRegular
                                  .copyWith(color: AppColors.kGrey50)),
                        )
                      : const SizedBox.shrink()),
              //_getCondition(context),
            ],
          );
        });
  }

  Widget _getTrailing(OtaCancellationPolicyController controller) {
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

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.cancellationPolicy),
      style: AppTheme.kHeading1Medium,
      maxLines: _kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getCancellationConditions(BuildContext context) {
    List<OtaCancellationPolicyListModel> cancellationPolicy =
        cancellationPolicyModel ?? [];

    return Offstage(
      offstage: controller.state.state ==
          OtaCancellationPolicyListModelState.collapsed,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
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
                      cancellationDaysDescription.isNotEmpty
                          ? Text(cancellationDaysDescription,
                              style: AppTheme.kBodyRegular
                                  .copyWith(color: AppColors.kGrey50))
                          : const SizedBox.shrink(),
                      cancellationChargeDescription.isNotEmpty
                          ? Text(cancellationChargeDescription,
                              style: AppTheme.kBodyRegular
                                  .copyWith(color: AppColors.kGrey50))
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: kSize20,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  String _getCancellationPolicyLine(BuildContext context) =>
      getTranslated(context, AppLocalizationsStrings.cancellationLine)
          .replaceAll('\\n', '\n')
          .trim();

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
