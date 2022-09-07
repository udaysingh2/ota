import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

class TourBookingFacilityList extends StatelessWidget {
  final List<TourBookingDetailsHighlight> facilityMap;
  const TourBookingFacilityList({
    Key? key,
    required this.facilityMap,
  }) : super(key: key);

  get kSize20 => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getFacilityList(context),
    );
  }

  List<Widget> _getFacilityList(BuildContext context) {
    List<Widget> facilityList = [];
    for (TourBookingDetailsHighlight facility in facilityMap) {
      if (facility.value != null) {
        facilityList.add(_getService(facility.key!, facility.value!));
        facilityList.add(const SizedBox(height: kSize6));
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
          width: kSize20,
          height: kSize20,
          color: AppColors.kGrey70,
        ),
        const SizedBox(width: kSize4),
        Expanded(
          child: Text(
            offerId,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }
}
