import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tours/confirm_booking/bloc/tour_confirm_booking_collapse_expand_bloc.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const int _kDefaultMaxLines = 1;
const int _kMaxTwoLines = 2;
const double _kHeadLineHeight = 1.25;
const double _kSmallLineHeight = 1.42;
const String _kUpArrow = "assets/images/icons/arrow_up.svg";
const String _kDownArrow = "assets/images/icons/arrow_down.svg";

class TourConfirmBookingReviewInfo extends StatelessWidget {
  final String? imageUrl;
  final String? tourName;
  final String? packageName;
  final String? noOfDays;
  final String? cancellationHeader;
  final DateTime? bookingDate;
  final String? startTime;
  final List<TourHighlightViewModel>? facilityMap;
  final double? adultTourPrice;
  final double? childTourPrice;
  final int? childCount;
  final ToursChildInfoViewModel? childInfo;
  final TourConfirmBookingCollapseExpandBloc tourPaymentCollapseExpandBloc;

  const TourConfirmBookingReviewInfo({
    Key? key,
    this.imageUrl,
    this.tourName,
    this.packageName,
    this.noOfDays,
    this.cancellationHeader,
    this.bookingDate,
    this.startTime,
    this.facilityMap,
    this.adultTourPrice,
    this.childTourPrice,
    this.childCount,
    this.childInfo,
    required this.tourPaymentCollapseExpandBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: kSize44,
                height: kSize44,
                child: imageUrl != null
                    ? _getImageCard()
                    : _getDefaultImage(context),
              ),
              const SizedBox(width: kSize16),
              Expanded(
                child: BlocBuilder(
                    bloc: tourPaymentCollapseExpandBloc,
                    builder: () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (tourName != null)
                            _getInfo(
                              tourName!,
                              AppTheme.kBodyMedium
                                  .copyWith(height: _kHeadLineHeight),
                              maxLines: _kMaxTwoLines,
                            ),
                          if (packageName != null)
                            _getInfo(
                              packageName!,
                              AppTheme.kSmallRegular.copyWith(
                                color: AppColors.kGrey50,
                              ),
                              maxLines: _kMaxTwoLines,
                            ),
                          if (tourPaymentCollapseExpandBloc.state ==
                              TourPaymentReviewCollapseExpandState.isExpanded)
                            ...getListOfWidget(context),
                          if (tourPaymentCollapseExpandBloc.state ==
                              TourPaymentReviewCollapseExpandState.isCollapsed)
                            ..._getOnCollapseInfo(context),
                        ],
                      );
                    }),
              ),
              const SizedBox(width: kSize16),
              InkWell(
                key: const Key("tourPaymentCollapseExpandKey"),
                onTap: () {
                  tourPaymentCollapseExpandBloc.toggle();
                },
                child: SizedBox(
                  width: kSize20,
                  height: kSize20,
                  child: BlocBuilder(
                      bloc: tourPaymentCollapseExpandBloc,
                      builder: () {
                        return SvgPicture.asset(
                          (tourPaymentCollapseExpandBloc.state ==
                                  TourPaymentReviewCollapseExpandState
                                      .isExpanded)
                              ? _kUpArrow
                              : _kDownArrow,
                        );
                      }),
                ),
              ),
            ],
          ),
          BlocBuilder(
            bloc: tourPaymentCollapseExpandBloc,
            builder: () {
              if (tourPaymentCollapseExpandBloc.state ==
                  TourPaymentReviewCollapseExpandState.isExpanded) {
                return Column(
                  children: [
                    const SizedBox(
                      height: kSize16,
                    ),
                    _getAdultPrice(context),
                    if (childCount != null && childCount! > 0)
                      const SizedBox(
                        height: kSize8,
                      ),
                    if (childCount != null && childCount! > 0)
                      _getChildrenPrice(context),
                  ],
                );
              }
              return const SizedBox(
                height: kSize16,
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _getOnCollapseInfo(BuildContext context) {
    List<Widget> infoList = [];

    if (noOfDays != null && noOfDays!.isNotEmpty) {
      infoList.add(_getInfo(
          (noOfDays!.addTrailingSpace() +
              getTranslated(context, AppLocalizationsStrings.days)),
          AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)));
    }
    infoList.add(_getInfo(_getDateTime(),
        AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)));
    if (cancellationHeader != null && cancellationHeader!.isNotEmpty) {
      infoList.add(_getInfo(cancellationHeader!, AppTheme.kSmallRegular));
    }
    return infoList;
  }

  List<Widget> getListOfWidget(BuildContext context) {
    return [
      if (packageName != null) const SizedBox(height: kSize8),
      _getFacilityView(context, facilityMap),
    ];
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          errorWidget: (context, url, error) => _getDefaultImage(context),
          placeholder: (context, url) => _getDefaultImage(context)),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return SvgPicture.asset(_kPlaceholderImage,
        fit: BoxFit.cover, width: MediaQuery.of(context).size.width - kSize48);
  }

  Widget _getInfo(String name, TextStyle? textStyle, {int? maxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines ?? _kDefaultMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getAdultPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getTranslated(context, AppLocalizationsStrings.adults),
            style: AppTheme.kBodyRegular.copyWith(height: _kHeadLineHeight)),
        _getPrice(context, adultTourPrice!),
      ],
    );
  }

  Widget _getChildrenPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
          TextSpan(
              text: getTranslated(context, AppLocalizationsStrings.children)
                  .addTrailingSpace(),
              style: AppTheme.kRichTextStyle(AppTheme.kBodyRegular)
                  .copyWith(height: _kHeadLineHeight)),
          TextSpan(
              text: _getChildInfoText(context),
              style: AppTheme.kRichTextStyle(AppTheme.kSmallerRegular).copyWith(
                color: AppColors.kGrey50,
                fontSize: kSize14,
                height: _kSmallLineHeight,
              ))
        ])),
        _getPrice(context, childTourPrice!),
      ],
    );
  }

  String _getDateTime() {
    return Helpers.getwwddMMMyy(bookingDate!).addTrailingComma() + startTime!;
  }

  String? _getChildInfoText(BuildContext context) {
    String? childAge;
    if (childInfo != null &&
        childInfo!.maxAge != null &&
        childInfo!.minAge != null &&
        (childInfo!.maxAge! > childInfo!.minAge!)) {
      childAge =
          '${getTranslated(context, AppLocalizationsStrings.ages).addTrailingSpace()}${childInfo!.minAge}-${childInfo!.maxAge}';
    }
    return childAge;
  }

  Widget _getPrice(BuildContext context, double price) {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Align(
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: currencyUtil.getFormattedPrice(price).addTrailingSpace(),
                style: AppTheme.kRichTextStyle(AppTheme.kBodyMedium).copyWith(
                    fontFamily: kFontFamily, height: _kHeadLineHeight)),
            TextSpan(
                text: getTranslated(context, AppLocalizationsStrings.pax)
                    .addLeadingSlash(),
                style: AppTheme.kRichTextStyle(AppTheme.kBodyMedium).copyWith(
                  fontFamily: kFontFamily,
                  height: _kHeadLineHeight,
                  color: AppColors.kGrey50,
                ))
          ]),
        ));
  }

  Widget _getFacilityView(
      BuildContext context, List<TourHighlightViewModel>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(
      BuildContext context, List<TourHighlightViewModel>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (TourHighlightViewModel facility in facilityMap) {
        if (facility.value != null) {
          facilityList.add(_getService(facility.key!, facility.value!));
          facilityList.add(const SizedBox(
            height: kSize4,
          ));
        }
      }
    }
    return facilityList;
  }

  Widget _getService(String assetId, String offerId) {
    String imageName = FacilityHelper.getAssetName(assetId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          imageName,
          width: kSize16,
          height: kSize16,
          color: AppColors.kGrey70,
        ),
        const SizedBox(
          width: kSize4,
        ),
        Expanded(
          child: Text(
            offerId,
            maxLines: _kDefaultMaxLines,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }
}
