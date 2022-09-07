import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_details/helpers/hotel_booking_details_helper.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/booking_details_location_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_room_info_view_model.dart';

import 'hotel_details_room_info_controller.dart';
import 'hotel_details_room_info_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";
const int _kMaxLines = 1;
const int _kMaxLines2 = 2;
const int _kDefaultRating = 0;

class HotelBookingDetailsRoomInfoWidget extends StatelessWidget {
  final String? imageUrl;
  final String? propertyName;
  final String? offerName;
  final int starRating;
  final List<HotelBookingDetailsRoomDetails>? roomDetailsList;
  final List<HotelBookingDetailsFacilityList>? facilityMap;
  final double? pricePerNight;
  final String? address;
  final String? phoneNumber;
  final double latitude;
  final double longitude;

  final HotelDetailsRoomInfoController controller =
      HotelDetailsRoomInfoController();

  HotelBookingDetailsRoomInfoWidget({
    Key? key,
    this.imageUrl,
    this.propertyName,
    this.offerName,
    this.facilityMap,
    this.pricePerNight,
    this.roomDetailsList,
    this.address,
    this.phoneNumber,
    this.starRating = _kDefaultRating,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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

        const SizedBox(height: kSize4),
        if (address != null) _getAddress(),
        if (address != null) const SizedBox(height: kSize4),
        _getLocationWidget(),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
          height: kSize32,
        ),
        if (offerName != null)
          _getName(
              name: offerName!,
              textStyle: AppTheme.kHeading1Medium,
              maxLines: _kMaxLines2),
        if (offerName != null) const SizedBox(height: kSize8),
        // if (roomDetailsList != null && roomDetailsList!.isNotEmpty)
        //   _getRoomsList(roomDetailsList!),
        // if (roomDetailsList != null && roomDetailsList!.isNotEmpty)
        //   const SizedBox(
        //     height: kSize4,
        //   ),
        _getRoomDetailsListHeader(context),
        const SizedBox(height: kSize16),
        BlocBuilder(
            bloc: controller,
            builder: () {
              return Offstage(
                offstage: controller.state.state ==
                    HotelDetailsRoomInfoModelState.collapsed,
                child: _getFacilityView(context, facilityMap),
              );
            }),
      ],
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

  Widget _getName(
      {required String name, TextStyle? textStyle, int maxLines = _kMaxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getFacilityView(BuildContext context,
      List<HotelBookingDetailsFacilityList>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(BuildContext context,
      List<HotelBookingDetailsFacilityList>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (int index = 0; index < facilityMap.length; index++) {
        String facilityFlag =
            HotelBookingDetailHelper.getName(facilityMap[index], context);
        if (facilityMap[index].value != null && facilityFlag.isNotEmpty) {
          facilityList.add(_getFacility(facilityMap[index], context));
          facilityList.add(const SizedBox(
            height: kSize6,
          ));
        }
      }
    }
    return facilityList;
  }

  Widget _getFacility(
      HotelBookingDetailsFacilityList facilityMap, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        _getSvgIcon(facilityMap),
        const SizedBox(
          width: kSize8,
        ),
        _getFacilityName(facilityMap, context),
      ],
    );
  }

  Widget _getSvgIcon(HotelBookingDetailsFacilityList facilityMap) {
    return SvgPicture.asset(
      HotelBookingDetailHelper.getSvgIcon(facilityMap.key ?? ''),
      height: kSize20,
      width: kSize20,
      color: AppColors.kGrey70,
    );
  }

  Widget _getFacilityName(
      HotelBookingDetailsFacilityList facilityMap, BuildContext context) {
    return Expanded(
      child: Text(
        HotelBookingDetailHelper.getName(facilityMap, context),
        style: AppTheme.kSmallRegular,
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getAddress() {
    return Text(
      address!,
      style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
    );
  }

  Widget _getLocationWidget() {
    return BookingDetailLocationWidget(
      phoneNumber: phoneNumber ?? '',
      latitude: latitude,
      longitude: longitude,
    );
  }

  Widget _getRoomDetailsListHeader(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.roomDetail),
                style: AppTheme.kBodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              _getTrailing(),
            ],
          );
        });
  }

  Widget _getTrailing() {
    return InkWell(
      borderRadius: BorderRadius.circular(kSize40),
      onTap: () {
        controller.toggle();
      },
      child: Padding(
        padding: const EdgeInsets.all(kSize8),
        child: Ink(
          height: kSize20,
          width: kSize20,
          child: controller.state.state ==
                  HotelDetailsRoomInfoModelState.expanded
              ? SvgPicture.asset(_arrowUp, height: kSize20, width: kSize20)
              : SvgPicture.asset(_arrowDown, height: kSize20, width: kSize20),
        ),
      ),
    );
  }
}
