import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_payment_success_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_success_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_service_card_list_view.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_payment_success_parameters.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/ota_reservation_success/bloc/ota_reservation_success_bloc.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_view_model.dart';
import 'package:provider/provider.dart';

const String _kCongatulationAssetName =
    "assets/images/icons/congratulation_image.svg";
const String _kReservationImagePlaceholder =
    "assets/images/icons/horizontal_card_placeholder.png";
const String _kHighlightsTimePlaceholder = "assets/images/icons/clock_icon.svg";
const String _kHighlightsTourTypePlaceholder =
    "assets/images/icons/user_icon.svg";
const String _kHighlightsGuideLanguagePlaceholder =
    "assets/images/icons/megaphone.svg";
const String _kHighlightsisNonRefundPlaceholder =
    "assets/images/icons/condition_black.svg";
const String _kTickIcon = "assets/images/icons/success_checkbox.svg";
const int _kSuccessMsgMaxLines = 3;
const int _kMaxLines = 1;
const int _kNameMaxLines = 2;

const String _kTourTime = 'tourTime';
const String _kTicketTime = 'ticketTime';
const String _kTourType = 'tourType';
const String _kGuideLanguage = 'guideLanguage';
const String _kIsNonRefund = 'isNonRefund';

const String _kNavigateToLandingPageKey = 'navigateToLandingPageKey';
const String _kNavigateToActivityPageKey = 'navigateToActivityPageKey';
const String _kTicketMultiplySign = 'x';
const String _kPaymentStatusTypeFirebase = 'Success';

class OtaReservationSuccess extends StatefulWidget {
  const OtaReservationSuccess({Key? key}) : super(key: key);

  @override
  OtaReservationSuccessState createState() => OtaReservationSuccessState();
}

class OtaReservationSuccessState extends State<OtaReservationSuccess> {
  final OtaReservationSuccessBloc _otaReservationSuccessBloc =
      OtaReservationSuccessBloc();
  final CurrencyUtil _currencyUtil = CurrencyUtil();
  OtaReservationSuccessArgumentModel? _argument;
  bool isFirstOrder = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFirstOrder = ModalRoute.of(context)?.settings.arguments as bool;
      _argument = Provider.of<OtaReservationSuccessArgumentModel>(context,
          listen: false);
      LandingPageViewModel landingPageViewModel =
          Provider.of<LandingPageViewModel>(context, listen: false);
      List<ServiceViewModel> serviceViewModel =
          landingPageViewModel.serviceList;

      _otaReservationSuccessBloc.loadArgumenrDetail(
        serviceCardType: _argument!.serviceCardType!,
        serviceCardList: serviceViewModel,
        argumentModel: _argument!,
      );
      if (!(_argument?.bookingForTicket ?? false)) {
        _publishFirebasePaymentSuccessDataForTours();
        isFirstOrder
            ? _getTourDataForFirstOrder()
            : _getTourDataForPurchaseOrder();
      } else {
        _getTicketAppFlyerData();
        isFirstOrder
            ? _getTicketDataForFirstOrder()
            : _getTicketDataForPurchaseOrder();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder(
        bloc: _otaReservationSuccessBloc,
        builder: () {
          return Scaffold(
            body: Column(
              children: [
                _buildSuccessHeaderView(),
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: kSize16,
                        ),
                        children: [
                          if (_otaReservationSuccessBloc.state
                              .otaResrvationServiceCardViewModel.isNotEmpty)
                            _buildServiceCardList(),
                          const SizedBox(height: kSize16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: kSize24),
                            child: _buildReservationDetail(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom +
                                kSize100,
                          )
                        ],
                      ),
                      _getBottomBar(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReservationDetail() {
    OtaReservationDetailModel otaReservationDetailModel =
        _otaReservationSuccessBloc.state.otaReservationDetailModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.yourReservation),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize8),
        if (_otaReservationSuccessBloc
                .state.otaReservationDetailModel.referenceId !=
            null)
          Text(
            getTranslated(context, AppLocalizationsStrings.referenceId)
                    .addTrailingColon()
                    .addTrailingSpace() +
                _otaReservationSuccessBloc
                    .state.otaReservationDetailModel.referenceId!,
            style: AppTheme.kBodyMedium,
          ),
        Padding(
          padding: const EdgeInsets.only(top: kSize8, bottom: kSize16),
          child: _buildReservationImage(),
        ),
        _buildTitleText(
          otaReservationDetailModel.providerName ?? '',
          maxLines: _kNameMaxLines,
        ),
        const SizedBox(
          height: kSize8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: kSize4, bottom: kSize16),
          child: _buildTitleText(
            otaReservationDetailModel.packageName ?? '',
            maxLines: _kNameMaxLines,
            theme: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          ),
        ),
        _buildHighlightsView(),
        _buildPackageViewWithPrice(),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        Padding(
          padding: const EdgeInsets.only(top: kSize16, bottom: kSize8),
          child: _buildTitleText(
              Helpers.getwwddMMMyy(
                  otaReservationDetailModel.bookingDate ?? DateTime.now()),
              theme: AppTheme.kBodyMedium),
        ),
        if (!(_argument?.bookingForTicket ?? false))
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _buildDetailRow(
              title:
                  getTranslated(context, AppLocalizationsStrings.numberOfdays),
              detailText: _getNoOfDaysText(
                otaReservationDetailModel,
              ),
              detailStyle: AppTheme.kBodyMedium,
            ),
          ),
        if ((otaReservationDetailModel.activityDuration ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _buildDetailRow(
              title: getTranslated(context, AppLocalizationsStrings.duration),
              detailText: otaReservationDetailModel.activityDuration ?? '',
              detailStyle: AppTheme.kBodyMedium,
            ),
          ),
        if (!(_argument?.bookingForTicket ?? false))
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _buildDetailRow(
              title:
                  getTranslated(context, AppLocalizationsStrings.noOfTravelers),
              detailText: _getNoOfTravelersText(otaReservationDetailModel),
              detailStyle: AppTheme.kBodyMedium,
            ),
          ),
        if (_argument?.bookingForTicket ?? false)
          const Padding(
            padding: EdgeInsets.only(top: kSize8, bottom: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ),
        if (_argument?.bookingForTicket ?? false)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize8),
            child: _buildTitleText(
                getTranslated(context, AppLocalizationsStrings.noOfTickets),
                theme: AppTheme.kBodyMedium),
          ),
        if (_argument?.bookingForTicket ?? false) _buildTicketsView(),
      ],
    );
  }

  String _getNoOfDaysText(OtaReservationDetailModel otaReservationDetailModel) {
    return (otaReservationDetailModel.noOfDays ?? 0)
            .toString()
            .addTrailingSpace() +
        getTranslated(context, AppLocalizationsStrings.days);
  }

  String _getNoOfTravelersText(
      OtaReservationDetailModel otaReservationDetailModel) {
    int adultCount = otaReservationDetailModel.adultCount ?? 0;
    String adultsText = getTranslated(context, AppLocalizationsStrings.adults)
            .addTrailingSpace() +
        adultCount.toString();

    int childCount = otaReservationDetailModel.childCount ?? 0;
    String childrenText =
        getTranslated(context, AppLocalizationsStrings.children)
                .addTrailingSpace()
                .addLeadingSpace() +
            childCount.toString().addTrailingSpace();

    return adultsText + (childCount == 0 ? '' : childrenText);
  }

  Widget _buildTicketsView() {
    List<TourOrTicketsType> tourOrTicketsType = _verifyTourOrTicket(
        _otaReservationSuccessBloc
                .state.otaReservationDetailModel.tourOrTicketsType ??
            []);
    return Column(
      children: tourOrTicketsType
          .map(
            (type) => Padding(
              padding: const EdgeInsets.only(bottom: kSize8),
              child: _getTicketDetailsRow(
                  context: context,
                  name: type.name ?? '',
                  noOfTickets: type.count,
                  price: ((type.count ?? 1) * (type.price ?? 0))),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHighlightsView() {
    List<Highlights> highlights =
        _otaReservationSuccessBloc.state.otaReservationDetailModel.highlights ??
            [];
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Column(
        children: highlights
            .map((highlight) => _buildFacilityDetailRow(
                  hightlightKey: highlight.key ?? '',
                  highlightText: highlight.value ?? '',
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPackageViewWithPrice() {
    List<TourOrTicketsType> tourOrTicketsType = _verifyTourOrTicket(
        _otaReservationSuccessBloc
                .state.otaReservationDetailModel.tourOrTicketsType ??
            []);
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Column(
      children: tourOrTicketsType
          .map(
            (type) => Padding(
              padding: const EdgeInsets.only(bottom: kSize16),
              child: _buildDetailRow(
                title: type.name ?? '',
                subtitle: ((type.maxAge != null && type.minAge != null)
                    ? '${getTranslated(context, AppLocalizationsStrings.ages).addTrailingSpace().addLeadingSpace()}${type.minAge ?? 0} - ${type.maxAge ?? 0}'
                    : ''),
                detailText: currencyUtil
                    .getFormattedPrice(type.price ?? 0)
                    .addTrailingSpace(),
                detailStyle: AppTheme.kBodyMedium,
                subDetailStyle: AppTheme.kBodyRegularGrey50
                    .copyWith(fontWeight: FontWeight.w500),
                subDetailText: !(_argument?.bookingForTicket ?? false)
                    ? getTranslated(context, AppLocalizationsStrings.pax)
                        .addLeadingSlash()
                    : getTranslated(context,
                            AppLocalizationsStrings.perTicketPriceLabel)
                        .addLeadingSlash(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildReservationImage() {
    String imageUrl =
        _otaReservationSuccessBloc.state.otaReservationDetailModel.imageUrl ??
            '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(kSize8),
      child: imageUrl.isEmpty
          ? _buildReservationImagePlaceholder()
          : CachedNetworkImage(
              width: double.infinity,
              height: kSize152,
              imageUrl: imageUrl,
              errorWidget: (context, _, __) =>
                  _buildReservationImagePlaceholder(),
              placeholder: (context, _) => _buildReservationImagePlaceholder(),
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildReservationImagePlaceholder() {
    return Image.asset(
      _kReservationImagePlaceholder,
      width: double.infinity,
      height: kSize150,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTitleText(String title,
      {int maxLines = _kMaxLines, TextStyle theme = AppTheme.kHeading1Medium}) {
    return Text(
      title,
      style: theme,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFacilityDetailRow(
      {required String hightlightKey, required String highlightText}) {
    if (hightlightKey.isEmpty || highlightText.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Row(
        children: [
          SvgPicture.asset(
            _getHightlightImage(hightlightKey),
            fit: BoxFit.contain,
            height: kSize16,
            width: kSize16,
          ),
          const SizedBox(width: kSize4),
          Text(
            highlightText,
            style: AppTheme.kSmallRegular,
          )
        ],
      ),
    );
  }

  String _getHightlightImage(String hightlightKey) {
    if (hightlightKey == _kTourTime || hightlightKey == _kTicketTime) {
      return _kHighlightsTimePlaceholder;
    } else if (hightlightKey == _kTourType) {
      return _kHighlightsTourTypePlaceholder;
    } else if (hightlightKey == _kGuideLanguage) {
      return _kHighlightsGuideLanguagePlaceholder;
    } else if (hightlightKey == _kIsNonRefund) {
      return _kHighlightsisNonRefundPlaceholder;
    }
    return '';
  }

  Widget _getTicketDetailsRow(
      {required BuildContext context,
      required String name,
      int? noOfTickets,
      required double price}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - kSize48) * 0.63,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  child: Text(name,
                      style: AppTheme.kBodyRegular,
                      maxLines: _kMaxLines,
                      overflow: TextOverflow.ellipsis)),
              if (noOfTickets != null)
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.gradient1
                        .createShader(Offset.zero & bounds.size);
                  },
                  child: Text(
                    _kTicketMultiplySign + noOfTickets.toString(),
                    style: AppTheme.kBodyRegular
                        .copyWith(color: AppColors.kTrueWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
        Text(
          _currencyUtil.getFormattedPrice(price),
          style: AppTheme.kBodyMedium,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required String title,
    required String detailText,
    String subtitle = '',
    TextStyle detailStyle = AppTheme.kBodyMedium,
    TextStyle subDetailStyle = AppTheme.kBodyMedium,
    String subDetailText = '',
    bool isGradientText = false,
  }) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTheme.kRichTextStyle(AppTheme.kBodyRegular),
            children: [
              if (subtitle.isNotEmpty)
                TextSpan(
                  text: subtitle,
                  style: AppTheme.kRichTextStyle(AppTheme.kSmallRegular
                      .copyWith(color: AppColors.kGrey50)),
                )
            ],
          ),
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        const SizedBox(width: kSize12),
        Expanded(
          child: isGradientText
              ? OtaGradientText(
                  gradientText: detailText,
                  gradientTextStyle: AppTheme.kBodyMedium,
                  textAlign: TextAlign.end,
                )
              : RichText(
                  text: TextSpan(
                    text: detailText,
                    style: AppTheme.kRichTextStyle(detailStyle),
                    children: [
                      if (subDetailText.isNotEmpty)
                        TextSpan(
                          text: subDetailText,
                          style: AppTheme.kRichTextStyle(subDetailStyle),
                        )
                    ],
                  ),
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
        )
      ],
    );
  }

  Widget _buildServiceCardList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSize24),
          child: Text(
            getTranslated(context,
                AppLocalizationsStrings.tourRobinhoodRecommendedServices),
            style: AppTheme.kHeading1Medium,
          ),
        ),
        const SizedBox(height: kSize16),
        OtaServiceCardListView(
          serviceCardList: _otaReservationSuccessBloc
              .state.otaResrvationServiceCardViewModel,
          serviceType: !(_argument?.bookingForTicket ?? false)
              ? OtaServiceType.activity
              : OtaServiceType.ticket,
        ),
        const SizedBox(height: kSize16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize21),
          child: OtaHorizontalDivider(
            dividerColor: AppColors.kBorderGrey,
            height: kSize1,
          ),
        ),
      ],
    );
  }

  void navigatorSwitcher() {
    switch (_argument!.serviceCardType!) {
      case ServiceCardType.tour:
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.otaBookingListScreen,
            (Route<dynamic> route) =>
                route.settings.name == AppRoutes.landingPage,
            arguments: "tour_key");
        break;
      default:
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.otaBookingListScreen,
            (Route<dynamic> route) =>
                route.settings.name == AppRoutes.landingPage,
            arguments: "hotel_key");
    }
  }

  Widget _buildSuccessHeaderView() {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.gradient2),
      padding: const EdgeInsets.only(
        right: kSize9,
        bottom: kSize8,
        top: kSize20,
        left: kSize14,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            SvgPicture.asset(
              _kCongatulationAssetName,
              fit: BoxFit.cover,
              height: kSize84,
              width: kSize100,
            ),
            const SizedBox(width: kSize16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _kTickIcon,
                        width: kSize20,
                        height: kSize20,
                      ),
                      const SizedBox(
                        width: kSize4,
                      ),
                      Expanded(
                        child: Text(
                          getTranslated(context,
                              AppLocalizationsStrings.paymentSuccessTitle),
                          style: AppTheme.kHeading1Medium
                              .copyWith(color: AppColors.kTertiary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    getTranslated(context,
                        AppLocalizationsStrings.tourPaymentSuccessMessage),
                    style: AppTheme.kSmallRegular.copyWith(
                      color: AppColors.kLight100,
                    ),
                    maxLines: _kSuccessMsgMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getBottomBar() {
    return OtaBottomButtonBar(
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      button1: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key(_kNavigateToLandingPageKey),
          borderRadius: AppTheme.kBorderRadiusAll24,
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: kSize10),
            child: OtaGradientText(
              gradientText:
                  getTranslated(context, AppLocalizationsStrings.backToHome),
              gradientTextStyle: AppTheme.kButton,
              textGradientStartColor: AppColors.kGradientStart,
              textGradientEndColor: AppColors.kGradientEnd,
              overflow: TextOverflow.ellipsis,
              maxlines: _kMaxLines,
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.landingPage,
                (Route<dynamic> route) =>
                    route.settings.name == AppRoutes.splashScreen);
          },
        ),
      ),
      button2: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key(_kNavigateToActivityPageKey),
          borderRadius: AppTheme.kBorderRadiusAll24,
          splashColor: AppColors.kGradientEnd,
          hoverColor: AppColors.kGradientEnd,
          highlightColor: AppColors.kGradientEnd,
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: kSize10),
            decoration: const BoxDecoration(
              gradient: AppColors.kPurpleGradient,
              borderRadius: AppTheme.kBorderRadiusAll24,
            ),
            child: Text(
              getTranslated(context, AppLocalizationsStrings.viewActivityList),
              overflow: TextOverflow.ellipsis,
              style: AppTheme.kButton.copyWith(color: AppColors.kWhiteColor),
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            navigatorSwitcher();
          },
        ),
      ),
    );
  }

  List<TourOrTicketsType> _verifyTourOrTicket(
      List<TourOrTicketsType> ticketTypeList) {
    List<TourOrTicketsType> verifiedList = [];
    for (TourOrTicketsType ticket in ticketTypeList) {
      if (ticket.count != null && ticket.count! > 0) {
        verifiedList.add(ticket);
      }
    }
    return verifiedList;
  }

  void _getTourAppFlyerData() {
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourNumberOfAdult,
        value: _otaReservationSuccessBloc
            .state.otaReservationDetailModel.adultCount);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourNumberOfChild,
        value: _otaReservationSuccessBloc
            .state.otaReservationDetailModel.childCount);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourContentType);
  }

  void _getTourAppFlyerDataForFirstOrder() {
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourNumberOfAdult,
        value: _otaReservationSuccessBloc
            .state.otaReservationDetailModel.adultCount);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourNumberOfChild,
        value: _otaReservationSuccessBloc
            .state.otaReservationDetailModel.childCount);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourContentType);
  }

  void _getTicketAppFlyerData() {
    _getAppFlyerDefaultTicketTypes();
    _getAppFlyerTicketTypes(_otaReservationSuccessBloc
        .state.otaReservationDetailModel.tourOrTicketsType);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketContentType);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketCurrency);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketContentType);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketCurrency);
  }

  void _getAppFlyerDefaultTicketTypes() {
    for (int i = 0; i < 4; i++) {
      if (i == 0) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxAQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxAPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxAQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxAPerPrice,
            value: 0.0);
      } else if (i == 1) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxBQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxBPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxBQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxBPerPrice,
            value: 0.0);
      } else if (i == 2) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxCQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxCPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxCQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxCPerPrice,
            value: 0.0);
      } else if (i == 3) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxDQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
            key: TicketPaymentSuccessAppFlyer.ticketPaxDPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxDQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
            key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxDPerPrice,
            value: 0.0);
      }
    }
  }

  void _getAppFlyerTicketTypes(List<TourOrTicketsType>? ticketTypeList) {
    int ticketQuantity = 0;
    if (ticketTypeList == null) {
      return;
    } else if (ticketTypeList.isEmpty) {
      return;
    } else {
      for (int i = 0; i < ticketTypeList.length; i++) {
        if (i == 0) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxAQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxAPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxAQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxAPerPrice,
              value: ticketTypeList[i].price);

          ticketQuantity = ticketTypeList[i].count != null
              ? ticketQuantity + ticketTypeList[i].count!
              : ticketQuantity + 0;
        } else if (i == 1) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxBQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxBPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxBQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxBPerPrice,
              value: ticketTypeList[i].price);

          ticketQuantity = ticketTypeList[i].count != null
              ? ticketQuantity + ticketTypeList[i].count!
              : ticketQuantity + 0;
        } else if (i == 2) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxCQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxCPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxCQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxCPerPrice,
              value: ticketTypeList[i].price);

          ticketQuantity = ticketTypeList[i].count != null
              ? ticketQuantity + ticketTypeList[i].count!
              : ticketQuantity + 0;
        } else if (i == 3) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxDQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
              key: TicketPaymentSuccessAppFlyer.ticketPaxDPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxDQuantity,
              value: ticketTypeList[i].count);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
              key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaxDPerPrice,
              value: ticketTypeList[i].price);

          ticketQuantity = ticketTypeList[i].count != null
              ? ticketQuantity + ticketTypeList[i].count!
              : ticketQuantity + 0;
        }
      }
      AppFlyerHelper.addIntValue(
          eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
          key: TicketPaymentSuccessAppFlyer.ticketTotalQuantity,
          value: ticketQuantity);

      AppFlyerHelper.addIntValue(
          eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
          key: TicketPaymentSuccessFirstOrderAppFlyer.ticketTotalQuantity,
          value: ticketQuantity);
    }
  }

  void _getTourDataForPurchaseOrder() {
    _getTourAppFlyerData();
    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.tourPaymentSuccessEvent);
    AppFlyerHelper.clearEvent(
        AppFlyerEvent.tourPaymentSuccessFirstBookingEvent);
  }

  void _getTourDataForFirstOrder() {
    _getTourAppFlyerDataForFirstOrder();
    AppFlyerHelper.stopCapturingEvent(
        AppFlyerEvent.tourPaymentSuccessFirstBookingEvent);
    AppFlyerHelper.clearEvent(AppFlyerEvent.tourPaymentSuccessEvent);
  }

  void _getTicketDataForFirstOrder() {
    AppFlyerHelper.stopCapturingEvent(
        AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent);
    AppFlyerHelper.clearEvent(AppFlyerEvent.ticketPaymentSuccessEvent);
  }

  void _getTicketDataForPurchaseOrder() {
    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.ticketPaymentSuccessEvent);
    AppFlyerHelper.clearEvent(
        AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent);
  }

  void _publishFirebasePaymentSuccessDataForTours() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.referenceId,
        value: _otaReservationSuccessBloc
            .state.otaReservationDetailModel.referenceId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.paymentStatus,
        value: _kPaymentStatusTypeFirebase);
    FirebaseHelper.stopCapturingEvent(FirebaseEvent.tourPaymentSuccess);
  }
}
