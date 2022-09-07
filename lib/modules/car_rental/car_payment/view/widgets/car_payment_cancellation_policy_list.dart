import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_payment/bloc/car_payment_bloc.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_view_model.dart';

const String _kUpArrowIcon = "assets/images/icons/arrow_up.svg";
const String _kDownArrowIcon = "assets/images/icons/arrow_down.svg";

class CarPaymentCancellationPolicy extends StatelessWidget {
  final CarPaymentBloc carPaymentBloc;
  final OtaCancellationPolicyController controller =
      OtaCancellationPolicyController();

  CarPaymentCancellationPolicy({
    Key? key,
    required this.carPaymentBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CancellationPolicyList> cancellationPolicy =
        carPaymentBloc.state.cancellationPolicyList;
    String cancellationPolicyDescription = getTranslated(
        context, AppLocalizationsStrings.carCancelPolicyConfigLine);
    if (cancellationPolicy.isEmpty && cancellationPolicyDescription.isEmpty) {
      return const SizedBox.shrink();
    }
    return BlocBuilder(
      bloc: controller,
      builder: () {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated(
                        context, AppLocalizationsStrings.cancelationPolicy),
                    style: AppTheme.kHeading1Medium,
                  ),
                ),
                OtaIconButton(
                  key: const Key('CancellationButton'),
                  icon: SvgPicture.asset(
                    controller.state.state ==
                            OtaCancellationPolicyListModelState.expanded
                        ? _kUpArrowIcon
                        : _kDownArrowIcon,
                  ),
                  onTap: () => controller.toggle(),
                )
              ],
            ),
            const SizedBox(height: kSize16),
            if (controller.state.state ==
                OtaCancellationPolicyListModelState.expanded)
              Column(
                children: cancellationPolicy
                    .map(
                      (policy) => Padding(
                        padding: const EdgeInsets.only(bottom: kSize20),
                        child: Text(
                          policy.cancellationMessage ?? '',
                          style: AppTheme.kBodyRegular.copyWith(
                            color: AppColors.kGrey50,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            if (controller.state.state ==
                    OtaCancellationPolicyListModelState.expanded &&
                cancellationPolicyDescription.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: kSize20),
                child: Text(
                  cancellationPolicyDescription.replaceAll('\\n', '\n'),
                  style: AppTheme.kSmallRegular.copyWith(
                    color: AppColors.kGrey50,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
