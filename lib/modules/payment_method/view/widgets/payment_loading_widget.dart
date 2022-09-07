import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kAnimationSize = 150.0;
const _kAnimationName = 'assets/animations/robin_hourglass_solid.json';
const _kNewLine = '\n';

class PaymentLoadingScreenWidget extends StatefulWidget {
  final String? title;
  const PaymentLoadingScreenWidget({Key? key, this.title}) : super(key: key);

  @override
  PaymentLoadingScreenWidgetState createState() =>
      PaymentLoadingScreenWidgetState();
}

class PaymentLoadingScreenWidgetState extends State<PaymentLoadingScreenWidget>
    with TickerProviderStateMixin {
  AnimationController? _lottieAnimationController;

  @override
  void initState() {
    _lottieAnimationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loadIngWidget(context));
  }

  @override
  void dispose() {
    _lottieAnimationController?.dispose();
    super.dispose();
  }

  Widget _loadIngWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kSize60, horizontal: kSize64),
          child: Text(
            widget.title ??
                getTranslated(
                    context, AppLocalizationsStrings.paymentLoadingHeader),
            style: AppTheme.kHeading1Medium,
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Lottie.asset(_kAnimationName,
              controller: _lottieAnimationController,
              width: _kAnimationSize,
              height: _kAnimationSize,
              fit: BoxFit.contain,
              //repeat: true,
              onLoaded: (composition) {
            _lottieAnimationController?.duration = composition.duration;
            _lottieAnimationController?.repeat();
          }),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kSize60, horizontal: kSize64),
            child: Text(
              getTranslated(context,
                      AppLocalizationsStrings.paymentLoadingMessageHeader) +
                  _kNewLine +
                  getTranslated(context,
                      AppLocalizationsStrings.paymentLoadingMessageContent),
              style: AppTheme.kHeading4.copyWith(color: AppColors.kBlack1),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
