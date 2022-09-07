import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/hotel/room_detail/helper/room_detail_helper.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_category_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

const _kMaxLines = 1;
const String _kBedDouble = "assets/images/icons/bed_double_gradient.svg";

class HotelRoomDetailInfoWidget extends StatelessWidget {
  final String? roomType;
  final List<FacilityModel> facilityList;
  final List<RoomCategoryViewModel>? roomList;
  const HotelRoomDetailInfoWidget({
    Key? key,
    this.roomType,
    this.roomList,
    this.facilityList = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppColors.kLight100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              roomType ?? "",
              style: AppTheme.kHeading1Medium,
            ),
            const SizedBox(height: kSize16),
            _buildAvailableRooms(roomList ?? []),
            _buildFacilitiesList(context, facilityList),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableRooms(List<RoomCategoryViewModel> roomCategoryList) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: roomCategoryList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSize8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                _kBedDouble,
                height: kSize20,
                width: kSize20,
                color: AppColors.kGrey70,
              ),
              const SizedBox(width: kSize8),
              Expanded(
                child: Text(
                  roomCategoryList[index].noOfRoomsAndName,
                  style: AppTheme.kSmallRegular,
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildFacilitiesList(
      BuildContext context, List<FacilityModel> facilityList) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: facilityList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              RoomDetailHelper.getName(facilityList[index], context).isNotEmpty
                  ? const EdgeInsets.only(bottom: kSize8)
                  : EdgeInsets.zero,
          child: _getRow(context, facilityList[index]),
        );
      },
    );
  }
}

Widget _getRow(BuildContext context, FacilityModel facilityList) {
  return RoomDetailHelper.getName(facilityList, context).isNotEmpty
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              RoomDetailHelper.getSvgIcon(facilityList.key),
              color: AppColors.kGrey70,
              height: kSize20,
              width: kSize20,
            ),
            const SizedBox(width: kSize8),
            Expanded(
              child: Text(
                RoomDetailHelper.getName(facilityList, context),
                style: AppTheme.kSmallRegular,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      : const SizedBox.shrink();
}
