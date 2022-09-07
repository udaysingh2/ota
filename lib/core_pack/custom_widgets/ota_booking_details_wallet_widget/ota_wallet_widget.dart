import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kIconWallet = 'assets/images/icons/wallet.svg';

class OtaWalletWidget extends StatelessWidget {
  final String? walletTitle;
  final EdgeInsetsGeometry padding;
  const OtaWalletWidget({
    Key? key,
    this.walletTitle,
    this.padding =
        const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize22),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          _buildVirtualPaymentImage(),
          const SizedBox(width: kSize10),
          Expanded(child: _setWalletName(context, walletTitle)),
        ],
      ),
    );
  }

  Widget _setWalletName(BuildContext context, String? text) {
    return Text(
      walletTitle ?? '',
      style: AppTheme.kBodyRegular,
      maxLines: 1,
    );
  }

  Widget _buildVirtualPaymentImage() {
    return SvgPicture.asset(
      _kIconWallet,
      fit: BoxFit.cover,
      width: kSize24,
      height: kSize24,
    );
  }
}
