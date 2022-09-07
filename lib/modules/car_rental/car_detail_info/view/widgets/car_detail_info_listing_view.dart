import 'package:flutter/material.dart';
import 'package:ota/modules/car_rental/car_detail_info/view/widgets/car_detail_info_listing_items.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_listing_model.dart';

class CarDetailInfoListingView extends StatelessWidget {
  final List<CarDetailInfoListingModel> list;
  const CarDetailInfoListingView({Key? key, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getListingView(list),
    );
  }

  List<Widget> _getListingView(List<CarDetailInfoListingModel> listing) {
    return List<Widget>.generate(
      listing.length,
      (index) {
        return CarDetailInfoListingItem(
          subHeaders: listing.elementAt(index).subHeaders,
          header: listing.elementAt(index).header,
          imageUrl: listing.elementAt(index).imageUrl,
          isHtml: listing.elementAt(index).isHtml,
        );
      },
    );
  }
}
