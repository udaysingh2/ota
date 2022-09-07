import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_controller.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';

class CancellationPolicy extends StatelessWidget {
  final CancellationPolicyController? cancellationPolicyController;
  final List<CancellationPolicyModel>? cancellationPolicyModel;

  const CancellationPolicy({
    Key? key,
    this.cancellationPolicyController,
    this.cancellationPolicyModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kSize24, bottom: kSize16),
          child: Text(
            getTranslated(context, AppLocalizationsStrings.cancellationPolicy),
            style: AppTheme.kHeading1Medium,
          ),
        ),
        getPolicy(context),
        _getCancellationPolicyLine(context).isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: kSize10),
                child: Text(
                  _getCancellationPolicyLine(context),
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget getPolicy(BuildContext context) {
    return BlocBuilder(
      bloc: cancellationPolicyController ?? CancellationPolicyController(),
      builder: () {
        return getPolicyData(context);
      },
    );
  }

  Widget getPolicyHeading(BuildContext context) {
    String policyHeading = '';
    switch (cancellationPolicyController!.state.cancellationPolicyState) {
      case CancellationPolicyState.freeCancellation:
        policyHeading = AppLocalizationsStrings.freeCancellation;
        break;
      case CancellationPolicyState.nonRefundable:
        policyHeading = AppLocalizationsStrings.nonRefundable;
        break;
      default:
        policyHeading = AppLocalizationsStrings.conditionalCancellation;
        break;
    }
    return Text(
      getTranslated(context, policyHeading),
      style: AppTheme.kBodyRegular.copyWith(color: AppColors.kSecondary),
    );
  }

  Widget getPolicyData(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cancellationPolicyModel?.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          String cancellationDaysDescription =
              cancellationPolicyModel![index].cancellationDaysDescription ?? '';
          String cancellationChargeDescription =
              cancellationPolicyModel![index].cancellationChargeDescription ??
                  '';

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
                            style: AppTheme.kSmallRegular
                                .copyWith(color: AppColors.kGrey50))
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: kSize20,
                    ),
                  ],
                );
        },
      ),
    );
  }

  String _getCancellationPolicyLine(BuildContext context) =>
      getTranslated(context, AppLocalizationsStrings.cancellationLine)
          .replaceAll('\\n', '\n')
          .trim();
}
