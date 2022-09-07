import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/reservation_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_room_info/reservation_room_info_controller.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_room_info/reservation_room_info_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_room_info_view_model.dart';

import '../../../../../../../core_pack/custom_widgets/ota_icon_button.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const String _kBedDouble = "assets/images/icons/bed_double.svg";
const String _kDefaultIcon = "assets/images/icons/uil_info-circle.svg";
const String _kConditionalCancellation = "conditional.cancellation";
const String _kFreeCancellation = "policy.cancellation.free";
const String _kNonRefundable = "policy.cancellation.non.refundable";
const int _kMaxLines = 1;
const int _kMaxLines2 = 2;
const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";

class ReservationRoomInfo extends StatelessWidget {
  final String? imageUrl;
  final String? propertyName;
  final String? offerName;
  final List<RoomDetails>? roomDetailsList;
  final List<FacilityList>? facilityMap;
  final String? cancellationPolicy;
  final double? pricePerNight;
  final String ratingText;
  final String addressText;
  final ReservationRoomInfoController controller =
      ReservationRoomInfoController();

  ReservationRoomInfo({
    Key? key,
    this.imageUrl,
    this.propertyName,
    this.offerName,
    this.facilityMap,
    this.pricePerNight,
    this.roomDetailsList,
    this.cancellationPolicy,
    this.ratingText = "1",
    this.addressText = "",
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
            height: kSize16,
          ),
          imageUrl != null ? _getImageCard() : _getDefaultImage(context),
          const SizedBox(
            height: kSize16,
          ),
          if (propertyName != null)
            _getName(
              propertyName!,
              AppTheme.kHeading1Medium,
              maxLines: _kMaxLines2,
            ),
          if (propertyName != null) const SizedBox(height: kSize4),
          Row(
            children: [
              if (ratingText.isNotEmpty)
                OtaStarRating(
                  starRating: (double.tryParse(ratingText)?.floor() ?? 1),
                  forceToOne: true,
                ),
              if (ratingText.isNotEmpty)
                const SizedBox(
                  width: kSize8,
                ),
              Expanded(
                child: Text(
                  addressText,
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                ),
              ),
            ],
          ),
          const OtaHorizontalDivider(
            height: kSize48,
            dividerColor: AppColors.kGrey10,
          ),
          _getRoomOffer(context),
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
    return SvgPicture.asset(_kPlaceholderImage,
        fit: BoxFit.cover, width: MediaQuery.of(context).size.width - kSize48);
  }

  Widget _getName(String name, TextStyle? textStyle,
      {int maxLines = _kMaxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getRoomsList(List<RoomDetails> roomDetailsList) {
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
          height: kSize6,
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

  Widget _getRoomText(
      List<RoomDetails> roomDetailsList, int index, BuildContext context) {
    return Expanded(
      child: Text(
        roomDetailsList[index].noOfRoomsAndName,
        style: AppTheme.kSmallRegular,
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getFacilityView(
      BuildContext context, List<FacilityList>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(
      BuildContext context, List<FacilityList>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (int index = 0; index < facilityMap.length; index++) {
        if (facilityMap[index].value != null) {
          facilityList.add(_getFacility(facilityMap[index], context));
          ReservationHelper.getName(facilityMap[index], context).isNotEmpty
              ? facilityList.add(const SizedBox(
                  height: kSize6,
                ))
              : const SizedBox.shrink();
        }
      }
    }
    facilityList.add(_getCancellationPolicy(context));
    facilityList.add(const SizedBox(
      height: kSize6,
    ));
    return facilityList;
  }

  Widget _getFacility(FacilityList facilityMap, BuildContext context) {
    return ReservationHelper.getName(facilityMap, context).isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _getSvgIcon(FacilityList facilityMap) {
    return SvgPicture.asset(
      ReservationHelper.getSvgIcon(facilityMap.key ?? ''),
      height: kSize20,
      width: kSize20,
      color: AppColors.kGrey70,
    );
  }

  Widget _getFacilityName(FacilityList facilityMap, BuildContext context) {
    return Expanded(
      child: Text(
        ReservationHelper.getName(facilityMap, context),
        style: AppTheme.kSmallRegular,
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getCancellationPolicy(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SvgPicture.asset(
          _kDefaultIcon,
          height: kSize20,
          width: kSize20,
        ),
        const SizedBox(
          width: kSize4,
        ),
        _getCancellationPolicyName(context, cancellationPolicy)
      ],
    );
  }

  Widget _getCancellationPolicyName(
      BuildContext context, String? cancellationPolicy) {
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
    return Expanded(
      child: Text(
        asset,
        style: AppTheme.kSmallRegular,
      ),
    );
  }

  Widget _getRoomOffer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (offerName != null)
          _getName(offerName!, AppTheme.kHeading1Medium, maxLines: _kMaxLines2),
        if (offerName != null) const SizedBox(height: kSize16),
        _getRoomListHeader(context),
        BlocBuilder(
            bloc: controller,
            builder: () {
              return Offstage(
                  offstage: controller.state.state ==
                      ReservationRoomInfoModelState.collapsed,
                  child: _getList(context));
            }),
      ],
    );
  }

  Widget _getList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: kSize16),
        if (roomDetailsList != null && roomDetailsList!.isNotEmpty)
          _getRoomsList(roomDetailsList!),
        if (roomDetailsList != null && roomDetailsList!.isNotEmpty)
          const SizedBox(height: kSize4),
        _getFacilityView(context, facilityMap),
      ],
    );
  }

  Widget _getRoomListHeader(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.roomDetail),
                style: AppTheme.kBodyMedium,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
              _getTrailing(),
            ],
          );
        });
  }

  Widget _getTrailing() {
    return OtaIconButton(
      width: kSize24,
      height: kSize20,
      padding: EdgeInsets.zero,
      icon: controller.state.state == ReservationRoomInfoModelState.expanded
          ? SvgPicture.asset(_arrowUp)
          : SvgPicture.asset(_arrowDown),
      onTap: () => controller.toggle(),
    );
  }
}
