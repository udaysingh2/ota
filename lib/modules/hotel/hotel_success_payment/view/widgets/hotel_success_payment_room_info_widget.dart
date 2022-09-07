import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const int _kMaxLines = 1;
const int _kMaxLines2 = 2;

class HotelSuccessPaymentRoomInfoWidget extends StatelessWidget {
  final String? imageUrl;
  final String? propertyName;
  final String? offerName;
  final List<RoomDetails>? roomDetailsList;
  final List<FacilityList>? facilityMap;
  final String? cancellationPolicy;
  final double? pricePerNight;
  final String? bookingID;

  const HotelSuccessPaymentRoomInfoWidget({
    Key? key,
    this.imageUrl,
    this.propertyName,
    this.offerName,
    this.facilityMap,
    this.pricePerNight,
    this.roomDetailsList,
    this.cancellationPolicy,
    this.bookingID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getHeading(context),
          const SizedBox(
            height: kSize8,
          ),
          if (bookingID != null)
            _getText(
                getTranslated(context, AppLocalizationsStrings.referenceId),
                bookingID!,
                AppTheme.kBodyMedium),
          const SizedBox(
            height: kSize24,
          ),
          imageUrl != null ? _getImageCard() : _getDefaultImage(context),
          const SizedBox(
            height: kSize16,
          ),
          if (propertyName != null)
            _getName(
              name: propertyName!,
              textStyle: AppTheme.kHeading1Medium,
              maxLines: _kMaxLines2,
            ),
          if (propertyName != null) const SizedBox(height: kSize8),
          if (offerName != null)
            _getName(
              name: offerName!,
              textStyle:
                  AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              maxLines: _kMaxLines2,
            ),
        ],
      ),
    );
  }

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.yourReservation),
      style: AppTheme.kHeading1Medium,
      maxLines: _kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: kSize152,
          errorWidget: (context, url, error) => _getDefaultImage(context),
          placeholder: (context, url) => _getDefaultImage(context)),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return SvgPicture.asset(
      _kPlaceholderImage,
      height: kSize152,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width - kSize48,
    );
  }

  Widget _getName({required String name, TextStyle? textStyle, int? maxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getText(String id, String idNumber, TextStyle textStyle) {
    return RichText(
        text: TextSpan(
            style: textStyle.copyWith(fontFamily: kFontFamily),
            children: [
          TextSpan(text: id.addTrailingColon()),
          TextSpan(text: idNumber)
        ]));
  }

  ///TODO: Need to remove the commented functions below once figma finalized.
// Widget _getRoomsList(List<RoomDetails> roomDetailsList) {
//   return ListView.separated(
//     itemCount: roomDetailsList.length,
//     physics: const NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     itemBuilder: (context, index) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           _getRoomIcon(),
//           const SizedBox(width: kSize4),
//           _getRoomText(roomDetailsList, index, context),
//         ],
//       );
//     },
//     separatorBuilder: (BuildContext context, int index) {
//       return const SizedBox(
//         height: kSize4,
//       );
//     },
//   );
// }

// Widget _getRoomIcon() {
//   return SvgPicture.asset(
//     _kBedDouble,
//     height: kSize20,
//     width: kSize20,
//   );
// }
//
// Widget _getRoomText(
//     List<RoomDetails> roomDetailsList, int index, BuildContext context) {
//   return Expanded(
//     child: Text(
//       roomDetailsList[index].category!.addTrailingSpace() +
//           roomDetailsList[index].roomType!.addTrailingSpace() +
//           roomDetailsList[index]
//               .numberOfRooms!
//               .toString()
//               .addOpeningParenthesis()
//               .addTrailingSpace() +
//           getTranslated(context, AppLocalizationsStrings.bedroom)
//               .addClosingParenthesis(),
//       style: AppTheme.kBody,
//       maxLines: _kMaxLines,
//       overflow: TextOverflow.ellipsis,
//     ),
//   );
// }
//
// Widget _getPrice(BuildContext context) {
//   CurrencyUtil _currencyUtil = CurrencyUtil();
//   return Align(
//       alignment: Alignment.centerRight,
//       child: RichText(
//         text: TextSpan(children: [
//           TextSpan(
//               text: _currencyUtil
//                   .getFormattedPrice(pricePerNight ?? 0)
//                   .addTrailingSpace(),
//               style: AppTheme.kHBody.copyWith(fontFamily: kFontFamily)),
//           TextSpan(
//               text: getTranslated(context, AppLocalizationsStrings.night)
//                   .addLeadingSlash(),
//               style: AppTheme.kBody.copyWith(fontFamily: kFontFamily))
//         ]),
//       ));
// }
//
// Widget _getFacilityView(
//     BuildContext context, List<FacilityList>? facilityMap) {
//   return Column(
//     children: _getFacilityList(context, facilityMap),
//   );
// }

// List<Widget> _getFacilityList(
//     BuildContext context, List<FacilityList>? facilityMap) {
//   List<Widget> facilityList = [];
//   if (facilityMap != null && facilityMap.isNotEmpty) {
//     for (int index = 0; index < facilityMap.length; index++) {
//       if (facilityMap[index].value != null) {
//         facilityList.add(_getFacility(facilityMap[index]));
//         facilityList.add(const SizedBox(
//           height: kSize4,
//         ));
//       }
//     }
//   }
//   facilityList.add(_getCancellationPolicy(context));
//   facilityList.add(const SizedBox(
//     height: kSize4,
//   ));
//   return facilityList;
// }

// Widget _getFacility(FacilityList facilityMap) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.baseline,
//     textBaseline: TextBaseline.alphabetic,
//     children: [
//       _getSvgIcon(facilityMap),
//       const SizedBox(
//         width: kSize4,
//       ),
//       _getFacilityName(facilityMap)
//     ],
//   );
// }

// Widget _getSvgIcon(FacilityList facilityMap) {
//   String _iconName = "";
//   switch (facilityMap.value) {
//     case _kPayment:
//       _iconName = _kPaymentIcon;
//       break;
//     case _kWifi:
//       _iconName = _kWifiIcon;
//       break;
//     case _kBreakfast:
//       _iconName = _kBreakfastIcon;
//       break;
//     default:
//       _iconName = _kDefaultIcon;
//   }
//   return SvgPicture.asset(
//     _iconName,
//     height: kSize20,
//     width: kSize20,
//   );
// }
//
// Widget _getFacilityName(FacilityList facilityMap) {
//   return Expanded(
//     child: Text(
//       facilityMap.key!,
//       style: AppTheme.kBody,
//       maxLines: _kMaxLines,
//       overflow: TextOverflow.ellipsis,
//     ),
//   );
// }
//
// Widget _getCancellationPolicy(BuildContext context) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.baseline,
//     textBaseline: TextBaseline.alphabetic,
//     children: [
//       SvgPicture.asset(
//         _kDefaultIcon,
//         height: kSize20,
//         width: kSize20,
//       ),
//       const SizedBox(
//         width: kSize4,
//       ),
//       _getCancellationPolicyName(context, cancellationPolicy)
//     ],
//   );
// }

// Widget _getCancellationPolicyName(
//     BuildContext context, String? cancellationPolicy) {
//   String _asset = "";
//   switch (cancellationPolicy) {
//     case _kNonRefundable:
//       _asset = getTranslated(context, AppLocalizationsStrings.nonRefundable);
//       break;
//     case _kFreeCancellation:
//       _asset =
//           getTranslated(context, AppLocalizationsStrings.freeCancellation);
//       break;
//     case _kConditionalCancellation:
//       _asset = getTranslated(
//           context, AppLocalizationsStrings.conditionalCancellation);
//       break;
//     default:
//       _asset = getTranslated(context, AppLocalizationsStrings.nonRefundable);
//   }
//   return Expanded(
//     child: Text(
//       _asset,
//       style: AppTheme.kBody,
//     ),
//   );
// }
}
