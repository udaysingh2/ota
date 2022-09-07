import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/promo_code_detail/bloc/promo_detail_bloc.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/apply_promotion_argument.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PromoDetailScreen extends StatefulWidget {
  const PromoDetailScreen({Key? key}) : super(key: key);

  @override
  PromoDetailScreenState createState() => PromoDetailScreenState();
}

class PromoDetailScreenState extends State<PromoDetailScreen> {
  final PromoDetailBloc promoDetailBloc = PromoDetailBloc();
  PromoCodeData? _promoModel;
  bool isInternetConnected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      promoDetailBloc.stream.listen((event) async {
        if (event.state != PromoCodeScreenState.loading) {
          OtaDialogLoader().hideLoader(context);
        }
        switch (event.state) {
          case PromoCodeScreenState.loading:
            await OtaDialogLoader().showLoader(context);
            break;
          case PromoCodeScreenState.none:
            break;
          case PromoCodeScreenState.removeSuccess:
            Navigator.pop(context, promoDetailBloc.state.promoCodeData);
            break;
          case PromoCodeScreenState.internetFailure:
            OtaNoInternetAlertDialog().showAlertDialog(context);
            break;
          case PromoCodeScreenState.failure1899:
            _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo1899),
            );
            break;
          case PromoCodeScreenState.failure1999:
            _showAlert(
              getTranslated(
                  context, AppLocalizationsStrings.errorPromoTimeOut1999),
            );
            break;
          case PromoCodeScreenState.failure3023:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3023));
            break;
          case PromoCodeScreenState.failure3024:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3024));
            break;
          case PromoCodeScreenState.failure3025:
            if (_promoModel?.applicationKey == OtaServiceType.hotel) {
              _showAlert(getTranslated(
                  context, AppLocalizationsStrings.failureHotelPromo3025));
            } else if (_promoModel?.applicationKey ==
                OtaServiceType.carRental) {
              _showAlert(getTranslated(
                  context, AppLocalizationsStrings.failureCarPromo3025));
            } else if (_promoModel?.applicationKey == OtaServiceType.tour ||
                _promoModel?.applicationKey == OtaServiceType.ticket) {
              _showAlert(getTranslated(
                  context, AppLocalizationsStrings.failureTourPromo3025));
            }
            break;
          case PromoCodeScreenState.failure3028:
          case PromoCodeScreenState.failure:
          case PromoCodeScreenState.removeFailure:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3028));
            break;
          case PromoCodeScreenState.failure3033:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3033));
            break;
          case PromoCodeScreenState.failure3034:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3034));
            break;
          case PromoCodeScreenState.failure3054:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3054));
            break;
          case PromoCodeScreenState.failure3068:
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failurePromo3068));
            break;
          case PromoCodeScreenState.success:
            Navigator.pop(context, event.promoCodeData);
            Navigator.pop(context, event.promoCodeData);
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _promoModel = ModalRoute.of(context)?.settings.arguments as PromoCodeData?;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.titlePromoCode),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: _promoModel?.promotion.promotionLink,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            _getBottomBar(context, _promoModel!),
          ],
        ),
      ),
    );
  }

  Widget _getBottomBar(BuildContext context, PromoCodeData model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSize20),
        child: OtaTextButton(
          key: const Key("KeyPromoButton"),
          title: model.isPromotionApplied
              ? getTranslated(context, AppLocalizationsStrings.useLater)
              : getTranslated(context, AppLocalizationsStrings.useNow),
          textHorizontalPadding: kSize70,
          onPressed: () async {
            if (model.isPromotionApplied) {
              await promoDetailBloc.removePromoCode(
                argument: model,
              );
            } else {
              await promoDetailBloc.applyPromoCode(
                ApplyPromoArgument(
                    bookingUrn: model.bookingUrn,
                    appliedPromo: model.promotion,
                    merchantId: model.merchantId),
                _promoModel?.applicationKey ?? "",
              );
            }
          },
        ),
      ),
    );
  }

  void _showAlert(String errorMessage) {
    OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: errorMessage,
      buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
      onPressed: () => Navigator.of(context).pop(),
    ).showAlertDialog(context);
  }
}
