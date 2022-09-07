import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/view_model/virtual_payment_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/ota_switch_button.dart';

const String _kMoneyAsset = "assets/images/icons/money.svg";
const int _kTime = 100;
const String _buildEnabledButton = "buildEnabledButton";
const String _buildDisabledButton = "buildDisabledButton";

class OtaVirtualWalletWidget extends StatefulWidget {
  final VirtualPaymentViewModel paymentModel;
  final VirtualPaymentBloc virtualPaymentBloc;
  final double amountToBeDeducted;
  const OtaVirtualWalletWidget({
    Key? key,
    required this.paymentModel,
    required this.virtualPaymentBloc,
    required this.amountToBeDeducted,
  }) : super(key: key);

  @override
  State<OtaVirtualWalletWidget> createState() => _OtaVirtualWalletWidgetState();
}

class _OtaVirtualWalletWidgetState extends State<OtaVirtualWalletWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation _circleAnimation;
  final CurrencyUtil _currencyUtil = CurrencyUtil();

  _setupSwitchButton() {
    if (_animationController == null) {
      _animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: _kTime));
      _circleAnimation = AlignmentTween(
              begin: widget.paymentModel.walletState == WalletState.on
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              end: widget.paymentModel.walletState == WalletState.on
                  ? Alignment.centerLeft
                  : Alignment.centerRight)
          .animate(CurvedAnimation(
              parent: _animationController!, curve: Curves.linear));
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupSwitchButton();
    if (widget.paymentModel.walletState == WalletState.disabled) {
      return _buildDisabledWidget();
    } else {
      return _buildEnableddWidget();
    }
  }

  Widget _buildDisabledWidget() {
    return Row(
      children: [
        SvgPicture.asset(
          _kMoneyAsset,
          height: kSize20,
          width: kSize20,
          color: AppColors.kGrey20,
        ),
        const SizedBox(width: kSize4),
        Text(
          (widget.paymentModel.state == VirtualPaymentState.success &&
                  widget.paymentModel.balance == 0.0)
              ? "${getTranslated(context, AppLocalizationsStrings.payWithWallet)}${_currencyUtil.getFormattedPrice(widget.paymentModel.balance ?? 0).addParenthesis().addLeadingSpace()}"
              : getTranslated(
                  context, AppLocalizationsStrings.walletNotAvialable),
          style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey20),
        ),
        const Spacer(),
        OtaSwitchButton(
          key: const Key(_buildDisabledButton),
          onTap: () {},
          isDisabled: true,
          animationController: _animationController,
          circleAnimation: _circleAnimation,
        )
      ],
    );
  }

  Widget _buildEnableddWidget() {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                _kMoneyAsset,
                height: kSize20,
                width: kSize20,
              ),
              const SizedBox(width: kSize4),
              OtaGradientTextWidget(
                text:
                    "${getTranslated(context, AppLocalizationsStrings.payWithWallet)}${_currencyUtil.getFormattedPrice(widget.paymentModel.balance ?? 0).addParenthesis().addLeadingSpace()}",
                style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey20),
              ),
              const Spacer(),
              OtaSwitchButton(
                key: const Key(_buildEnabledButton),
                onTap: () {
                  if (_animationController!.isCompleted) {
                    _animationController!.reverse();
                    widget.virtualPaymentBloc.removeWallet();
                  } else {
                    _animationController!.forward();
                    widget.virtualPaymentBloc
                        .useWallet(widget.amountToBeDeducted);
                  }
                },
                animationController: _animationController,
                circleAnimation: _circleAnimation,
              )
            ],
          ),
          if (widget.paymentModel.walletState == WalletState.on)
            const SizedBox(height: kSize8),
          if (widget.paymentModel.walletState == WalletState.on)
            Row(
              children: [
                const Spacer(),
                OtaGradientTextWidget(
                  text: _currencyUtil
                      .getFormattedPrice(
                          widget.paymentModel.walletPaidAmmount ?? 0)
                      .addLeadingDash(),
                  style: AppTheme.kBodyMedium,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
