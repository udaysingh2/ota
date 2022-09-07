import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/payment_method/view/widgets/payment_method_tile.dart';
import 'package:ota/modules/payment_method/view_model/payment_method_argument_model.dart';

const String _kPaymentMethodTileKey = 'payment_method_tile';

class PaymentMethodListScreen extends StatelessWidget {
  const PaymentMethodListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentMethodArgs = ModalRoute.of(context)?.settings.arguments;
    final List<PaymentMethodArgumentModel> paymentMethodList =
        paymentMethodArgs != null
            ? paymentMethodArgs as List<PaymentMethodArgumentModel>
            : [];
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.paymentMethods),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          children: <Widget>[
            _buildPaymentMethodListView(paymentMethodList),
            const SizedBox(height: kSize30),
            Text(
              getTranslated(context, AppLocalizationsStrings.paymentMethodInfo),
              style: AppTheme.kSmall1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodListView(
      List<PaymentMethodArgumentModel> paymentMethodList) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: kSize24),
      itemCount: paymentMethodList.length,
      itemBuilder: (context, index) {
        return PaymentMethodTile(
          key: const Key(_kPaymentMethodTileKey),
          nickname: paymentMethodList[index].nickname,
          cardMask: paymentMethodList[index].cardMask,
          paymentMethodType: paymentMethodList[index].paymentMethodType,
          isDefault: paymentMethodList[index].isDefault,
          onTap: () {
            Navigator.of(context).pop(paymentMethodList[index].paymentMethodId);
          },
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: kSize16),
    );
  }
}
