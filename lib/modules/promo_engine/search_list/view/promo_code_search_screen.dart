import 'package:flutter/material.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/hotel/promo_add_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_matching_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/promo_code_detail/bloc/promo_detail_bloc.dart';
import 'package:ota/modules/promo_engine/search_list/bloc/public_promo_bloc.dart';
import 'package:ota/modules/promo_engine/search_list/view/widgets/promo_code_tile_widget.dart';
import 'package:ota/modules/promo_engine/search_list/view/widgets/promo_search_input_widget.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/apply_promotion_argument.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

const double _kTopHeight = 180;
const double _kHeight = 0.6;

class PromoCodeSearchScreen extends StatefulWidget {
  const PromoCodeSearchScreen({Key? key}) : super(key: key);

  @override
  State<PromoCodeSearchScreen> createState() => _PromoCodeSearchScreenState();
}

class _PromoCodeSearchScreenState extends State<PromoCodeSearchScreen> {
  final PublicPromotionBloc _publicPromotionBloc = PublicPromotionBloc();
  final PromoDetailBloc _applyPromoBloc = PromoDetailBloc();
  final TextEditingController _textFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late PublicPromotionArgument? argument;
  String? appFlyerPromoCode;
  String? appFlyerPromoType;

  @override
  void dispose() {
    _publicPromotionBloc.dispose();
    _applyPromoBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.promoAddEvent);
      argument = ModalRoute.of(context)?.settings.arguments
          as PublicPromotionArgument?;
      _getPromoCodes();
    });
    _publicPromotionBloc.stream.listen((event) async {
      if (event.state == PublicPromotionScreenState.searchEmptyListLoading ||
          event.state == PublicPromotionScreenState.searchFailureLoading ||
          event.state == PublicPromotionScreenState.searchSuccessLoading ||
          event.state == PublicPromotionScreenState.searchListLoading) {
        await OtaDialogLoader().showLoader(context);
      } else {
        OtaDialogLoader().hideLoader(context);
      }
      if (event.state == PublicPromotionScreenState.internetFailure ||
          event.state == PublicPromotionScreenState.searchInternetFailure ||
          event.state ==
              PublicPromotionScreenState.searchErrorInternetFailure ||
          event.state ==
              PublicPromotionScreenState.searchSuccessInternetFailure ||
          event.state ==
              PublicPromotionScreenState.searchEmptyListInternetFailure) {
        await OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });

    _applyPromoBloc.stream.listen((event) async {
      if (event.state != PromoCodeScreenState.loading) {
        OtaDialogLoader().hideLoader(context);
      }
      switch (event.state) {
        case PromoCodeScreenState.loading:
          await OtaDialogLoader().showLoader(context);
          break;
        case PromoCodeScreenState.none:
        case PromoCodeScreenState.removeSuccess:
        case PromoCodeScreenState.removeFailure:
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
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3023));
          break;
        case PromoCodeScreenState.failure3024:
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3024));
          break;
        case PromoCodeScreenState.failure3025:
          if (argument?.applicationKey == OtaServiceType.hotel) {
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failureHotelPromo3025));
          } else if (argument?.applicationKey == OtaServiceType.carRental) {
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failureCarPromo3025));
          } else if (argument?.applicationKey == OtaServiceType.tour ||
              argument?.applicationKey == OtaServiceType.ticket) {
            _showAlert(getTranslated(
                context, AppLocalizationsStrings.failureTourPromo3025));
          }
          break;
        case PromoCodeScreenState.failure3028:
        case PromoCodeScreenState.failure:
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3028));
          break;
        case PromoCodeScreenState.failure3033:
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3033));
          break;
        case PromoCodeScreenState.failure3034:
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3034));
          break;
        case PromoCodeScreenState.failure3054:
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3054));
          break;
        case PromoCodeScreenState.failure3068:
          _showAlert(
              getTranslated(context, AppLocalizationsStrings.failurePromo3068));
          break;
        case PromoCodeScreenState.success:
          Navigator.pop(context, event.promoCodeData);
          break;
      }
      if (event.state == PromoCodeScreenState.success) {
        _getPromoCodeDataSuccess(event.promoCodeData);
      } else if (event.state == PromoCodeScreenState.failure ||
          event.state == PromoCodeScreenState.failure1999 ||
          event.state == PromoCodeScreenState.failure1899 ||
          event.state == PromoCodeScreenState.failure3023 ||
          event.state == PromoCodeScreenState.failure3024 ||
          event.state == PromoCodeScreenState.failure3025 ||
          event.state == PromoCodeScreenState.failure3028 ||
          event.state == PromoCodeScreenState.failure3033 ||
          event.state == PromoCodeScreenState.failure3034 ||
          event.state == PromoCodeScreenState.failure3054 ||
          event.state == PromoCodeScreenState.failure3068) {
        _getPromoCodeDataFailure(event.promoCodeData);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.promoSearchTitle),
      ),
      resizeToAvoidBottomInset: false,
      body: Material(
        child: SafeArea(
          bottom: true,
          top: false,
          left: false,
          right: false,
          child: BlocBuilder(
            bloc: _publicPromotionBloc,
            builder: () {
              switch (_publicPromotionBloc.state.state) {
                case PublicPromotionScreenState.none:
                case PublicPromotionScreenState.empty:
                case PublicPromotionScreenState.searchEmptyListLoading:
                case PublicPromotionScreenState.searchEmptyListInternetFailure:
                  return _buildSuccessScreen(const SizedBox());
                case PublicPromotionScreenState.loading:
                  return const Center(child: OTALoadingIndicator());
                case PublicPromotionScreenState.failure:
                case PublicPromotionScreenState.internetFailure:
                  return _promoFailureWidget();
                case PublicPromotionScreenState.searchFailure:
                case PublicPromotionScreenState.searchFailureLoading:
                case PublicPromotionScreenState.searchErrorInternetFailure:
                  return _buildSuccessScreen(_noResultWidget());
                case PublicPromotionScreenState.searchListLoading:
                case PublicPromotionScreenState.success:
                case PublicPromotionScreenState.searchInternetFailure:
                  return _buildSuccessScreen(_buildPromoCodeListView(
                      _publicPromotionBloc.state.promotionList!));
                case PublicPromotionScreenState.searchSuccess:
                case PublicPromotionScreenState.searchSuccessLoading:
                case PublicPromotionScreenState.searchSuccessInternetFailure:
                  return _buildSuccessScreen(_buildSuccessSearchResultScreen(
                      _publicPromotionBloc.state.searchedPromotionCode!));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(Widget screen) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildSearchBar(),
      screen,
    ]);
  }

  Widget _buildSuccessSearchResultScreen(PublicPromotion promotion) {
    return _buildPromoCodeListView(_publicPromotionBloc.searchedListResult);
  }

  Widget _buildPromoCodeListView(List<PublicPromotion> promotions) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: kSize8, bottom: kSize16),
        itemCount: promotions.length,
        itemBuilder: (context, index) {
          if (_publicPromotionBloc.isNewDataRequired(
              index, argument!.pageOffset)) {
            argument!.pageOffset++;
            _publicPromotionBloc.getPromotionData(
                argument: argument, forceFetch: true);
          }
          return PromoCodeTileWidget(
            promotion: promotions[index],
            onItemClick: () async => await _isInternetConnected()
                ? _navigateToPromoCodeDetailScreen(context, promotions[index])
                : _showNoInternetAlert(context),
            onUseNowClick: () {
              AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.promoAddEvent);
              _getAppFlyerPromoValue(promotions[index]);
              _applyPromoBloc.applyPromoCode(
                  ApplyPromoArgument(
                      bookingUrn: argument!.bookingUrn,
                      appliedPromo: promotions[index],
                      merchantId: argument!.merchantId),
                  argument!.applicationKey);
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: kSize8),
      ),
    );
  }

  Widget _buildSearchBar() {
    return PromoSearchInputWidget(
      searchHintText: getTranslated(
          context, AppLocalizationsStrings.promoSearchPlaceHolder),
      searchTextController: _textFieldController,
      onCrossButtonTap: onCrossButtonTap,
      onChanged: (txt) {
        if (txt.isEmpty) {
          _onCrossTapped();
        }
      },
      focusNode: _focusNode,
      onSubmitted: onSubmitted,
    );
  }

  _onCrossTapped() {
    _publicPromotionBloc.onCrossButtonTap();
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

  _noResultWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * _kHeight,
      child: OtaNoMatchingResultWidget(
        errorTextFooter:
            getTranslated(context, AppLocalizationsStrings.promoNoSearchResult),
        errorTextHeader: getTranslated(context, AppLocalizationsStrings.sorry),
      ),
    );
  }

  Widget _promoFailureWidget() {
    return OtaNetworkErrorWidgetWithRefresh(
      onRefresh: () async => await _getPromoCodes(),
      height: MediaQuery.of(context).size.height - _kTopHeight,
    );
  }

  _getPromoCodes() {
    _publicPromotionBloc.getPromotionData(argument: argument);
  }

  onCrossButtonTap() {
    FocusScope.of(context).unfocus();
    _publicPromotionBloc.onCrossButtonTap();
  }

  onSubmitted(String searchText) async {
    if (searchText.isNotEmpty) {
      if (argument != null) {
        argument!.voucherCode = searchText.toUpperCase();
      }
      _publicPromotionBloc.getPromoCodeSearchData(argument);
    }
  }

  void _navigateToPromoCodeDetailScreen(
      BuildContext context, PublicPromotion promotion) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.promoDetailScreen,
      arguments: PromoCodeData(
        promotion: promotion,
        priceViewModel: null,
        isPromotionApplied: false,
        bookingUrn: argument!.bookingUrn,
        merchantId: argument!.merchantId,
        applicationKey: argument!.applicationKey,
      ),
    );
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  void _showNoInternetAlert(BuildContext context) {
    OtaNoInternetAlertDialog().showAlertDialog(context);
  }

  void _getPromoCodeDataSuccess(PromoCodeData? data) {
    AppFlyerLogger logger = AppFlyerLogger();
    logger.addKeyValue(
        key: PromoAddAppFlyer.promoName, value: appFlyerPromoCode);
    logger.addCurrency(key: PromoAddAppFlyer.promoCurrency);
    logger.addDoubleValue(
        key: PromoAddAppFlyer.promoAmount,
        value: data?.priceViewModel?.effectiveDiscount);
    logger.addKeyValue(
        key: PromoAddAppFlyer.promoType, value: appFlyerPromoType);
    logger.addKeyValue(key: PromoAddAppFlyer.promoSuccess, value: "Success");
    logger.publishToSuperApp(AppFlyerEvent.promoAddEvent);
  }

  void _getPromoCodeDataFailure(PromoCodeData? data) {
    AppFlyerLogger logger = AppFlyerLogger();
    logger.addKeyValue(
        key: PromoAddAppFlyer.promoName, value: appFlyerPromoCode);
    logger.addCurrency(key: PromoAddAppFlyer.promoCurrency);
    logger.addDoubleValue(
        key: PromoAddAppFlyer.promoAmount,
        value: data?.priceViewModel?.effectiveDiscount);
    logger.addKeyValue(
        key: PromoAddAppFlyer.promoType, value: appFlyerPromoType);
    logger.addKeyValue(key: PromoAddAppFlyer.promoSuccess, value: "Failure");
    logger.publishToSuperApp(AppFlyerEvent.promoAddEvent);
  }

  void _getAppFlyerPromoValue(PublicPromotion data) {
    appFlyerPromoCode = data.promotionCode;
    appFlyerPromoType = data.promotionType;
  }
}
