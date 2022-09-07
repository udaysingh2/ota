import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_discount_price_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/hotel_payment_min_max_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/hotel_payment_facility_list_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_room_view_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const String _kBedDouble = "assets/images/icons/bed_double.svg";
const String _kConditionalCancellation = "conditional.cancellation";
const String _kFreeCancellation = "policy.cancellation.free";
const String _kNonRefundable = "policy.cancellation.non.refundable";
const int _kMaxLines = 1;
const int _kMaxLines2 = 2;
const String _kUpArrow = "assets/images/icons/arrow_up.svg";
const String _kDownArrow = "assets/images/icons/arrow_down.svg";

class HotelPaymentReservationRoomInfo extends StatelessWidget {
  final String? imageUrl;
  final String? propertyName;
  final String? offerName;
  final List<HotelPaymentRoomDetails>? roomDetailsList;
  final List<HotelPaymentFacilityList>? facilityMap;
  final String? cancellationPolicy;
  final double? pricePerNight;
  final int room;
  final int night;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final HotelPaymentMinMaxBloc hotelPaymentMinMaxBloc;
  final double? percentageDiscount;
  final double? priceBeforeDiscount;
  final double totalAmount;

  const HotelPaymentReservationRoomInfo({
    Key? key,
    this.imageUrl,
    this.propertyName,
    this.offerName,
    this.facilityMap,
    this.pricePerNight,
    this.roomDetailsList,
    this.cancellationPolicy,
    this.room = 0,
    this.night = 0,
    required this.checkOutDate,
    required this.hotelPaymentMinMaxBloc,
    required this.checkInDate,
    required this.percentageDiscount,
    this.priceBeforeDiscount,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
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
                    bloc: hotelPaymentMinMaxBloc,
                    builder: () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (propertyName != null)
                            _getName(
                              propertyName!,
                              AppTheme.kBodyMedium,
                              maxLines: _kMaxLines2,
                            ),
                          const SizedBox(
                            height: kSize8,
                          ),
                          if (offerName != null)
                            _getName(
                              offerName!,
                              AppTheme.kSmallRegular.copyWith(
                                color: AppColors.kGrey50,
                                height: kSize1,
                              ),
                              maxLines: _kMaxLines2,
                            ),
                          const SizedBox(
                            height: kSize8,
                          ),
                          _getName(
                            getRoomAndNight(context, room, night),
                            AppTheme.kSmallRegular.copyWith(
                              color: AppColors.kGrey50,
                              height: kSize1,
                            ),
                            maxLines: _kMaxLines,
                          ),
                          const SizedBox(
                            height: kSize8,
                          ),
                          _getName(
                            Helpers.getddMMMyyyy(checkInDate)
                                    .addTrailingDash() +
                                Helpers.getddMMMyyyy(checkOutDate),
                            AppTheme.kSmallRegular.copyWith(
                              color: AppColors.kGrey50,
                              height: kSize1,
                            ),
                            maxLines: _kMaxLines,
                          ),
                          if (cancellationPolicy != null)
                            const SizedBox(
                              height: kSize8,
                            ),
                          if (cancellationPolicy != null)
                            _getCancellationPolicyName(
                              context,
                              cancellationPolicy!,
                              AppTheme.kSmallRegular.copyWith(
                                color: AppColors.kGrey70,
                                height: kSize1,
                              ),
                              maxLines: _kMaxLines,
                            ),
                          if (hotelPaymentMinMaxBloc.state ==
                              HotelPaymentMinMaxState.isExpanded)
                            ...getListOfWidget(context)
                        ],
                      );
                    }),
              ),
              const SizedBox(width: kSize16),
              Container(
                transform:
                    Matrix4.translationValues(kSize8, -kSize8, Offset.zero.dy),
                child: OtaIconButton(
                  icon: BlocBuilder(
                      bloc: hotelPaymentMinMaxBloc,
                      builder: () {
                        return SvgPicture.asset(
                          (hotelPaymentMinMaxBloc.state ==
                                  HotelPaymentMinMaxState.isExpanded)
                              ? _kUpArrow
                              : _kDownArrow,
                        );
                      }),
                  key: const Key("hotelPaymentMinMaxKey"),
                  onTap: () {
                    hotelPaymentMinMaxBloc.toggle();
                  },
                ),
              ),
            ],
          ),
          BlocBuilder(
              bloc: hotelPaymentMinMaxBloc,
              builder: () {
                if (hotelPaymentMinMaxBloc.state ==
                    HotelPaymentMinMaxState.isExpanded) {
                  return Align(
                      alignment: Alignment.centerRight,
                      child: OtaDiscountPriceWidget(
                        percentageDiscount: percentageDiscount?.toInt(),
                        pricePerNight: pricePerNight ?? 0,
                        priceBeforeDiscount: priceBeforeDiscount,
                        totalAmount: totalAmount,
                      ));
                }
                return const SizedBox(
                  height: kSize22,
                );
              }),
        ],
      ),
    );
  }

  String getRoomAndNight(BuildContext context, int room, int night) {
    return room.toString().addTrailingSpace() +
        getTranslated(context, AppLocalizationsStrings.roomLabel)
            .toString()
            .addTrailingComma()
            .addTrailingSpace() +
        night.toString().addTrailingSpace() +
        getTranslated(context, AppLocalizationsStrings.nights).toString();
  }

  List<Widget> getListOfWidget(BuildContext context) {
    return [
      if (propertyName != null) const SizedBox(height: kSize4),
      if (offerName != null) const SizedBox(height: kSize8),
      if (roomDetailsList != null && roomDetailsList!.isNotEmpty)
        _getRoomsList(roomDetailsList!),
      if (roomDetailsList != null && roomDetailsList!.isNotEmpty)
        const SizedBox(
          height: kSize8,
        ),
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

  Widget _getName(String name, TextStyle? textStyle, {int? maxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines ?? _kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getRoomsList(List<HotelPaymentRoomDetails> roomDetailsList) {
    return ListView.separated(
      itemCount: roomDetailsList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getRoomIcon(),
            const SizedBox(width: kSize4),
            _getRoomText(roomDetailsList, index, context),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: kSize8,
        );
      },
    );
  }

  Widget _getRoomIcon() {
    return SvgPicture.asset(
      _kBedDouble,
      height: kSize20,
      width: kSize20,
    );
  }

  Widget _getRoomText(List<HotelPaymentRoomDetails> roomDetailsList, int index,
      BuildContext context) {
    return Expanded(
      child: Text(
        roomDetailsList[index].noOfRoomsAndName,
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey70),
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getFacilityView(
      BuildContext context, List<HotelPaymentFacilityList>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(
      BuildContext context, List<HotelPaymentFacilityList>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (int index = 0; index < facilityMap.length; index++) {
        if (facilityMap[index].value != null) {
          facilityList.add(_getFacility(facilityMap[index], context));
          HotelPaymentFacilityListHelper.getName(facilityMap[index], context)
                  .isNotEmpty
              ? facilityList.add(const SizedBox(
                  height: kSize8,
                ))
              : const SizedBox.shrink();
        }
      }
    }

    facilityList.add(const SizedBox(
      height: kSize8,
    ));
    return facilityList;
  }

  Widget _getFacility(
      HotelPaymentFacilityList facilityMap, BuildContext context) {
    return HotelPaymentFacilityListHelper.getName(facilityMap, context)
            .isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              _getSvgIcon(facilityMap),
              const SizedBox(
                width: kSize4,
              ),
              _getFacilityName(facilityMap, context)
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _getSvgIcon(HotelPaymentFacilityList facilityMap) {
    return SvgPicture.asset(
      HotelPaymentFacilityListHelper.getSvgIcon(facilityMap.key ?? ''),
      height: kSize20,
      width: kSize20,
      color: AppColors.kGrey70,
    );
  }

  Widget _getFacilityName(
      HotelPaymentFacilityList facilityMap, BuildContext context) {
    return Expanded(
      child: Text(
        HotelPaymentFacilityListHelper.getName(facilityMap, context),
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey70),
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getCancellationPolicyName(
      BuildContext context, String? cancellationPolicy, TextStyle? textStyle,
      {int? maxLines}) {
    String asset = "";
    switch (cancellationPolicy) {
      case _kNonRefundable:
        asset = getTranslated(context, AppLocalizationsStrings.nonRefundable);
        break;
      case _kFreeCancellation:
        asset =
            getTranslated(context, AppLocalizationsStrings.freeCancellation);
        break;
      case _kConditionalCancellation:
        asset = getTranslated(
            context, AppLocalizationsStrings.conditionalCancellation);
        break;
      default:
        asset = getTranslated(context, AppLocalizationsStrings.nonRefundable);
    }
    return Text(
      asset,
      style: textStyle,
      maxLines: maxLines,
    );
  }
}
