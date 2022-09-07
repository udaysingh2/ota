import 'package:flutter/material.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_listing_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view/widgets/car_detail_more_info_listing_items.dart';

class CarDetailMoreInfoListingView extends StatelessWidget {
  final List<CarDetailMoreInfoListingModel> list;
  const CarDetailMoreInfoListingView({Key? key, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getListingView(list),
    );
  }

  List<Widget> _getListingView(List<CarDetailMoreInfoListingModel> listing) {
    return List<Widget>.generate(listing.length, (index) {
      return CarDetailMoreInfoListingItem(
        subHeaders: listing.elementAt(index).subHeaders,
        header: listing.elementAt(index).header,
        imageUrl: listing.elementAt(index).imageUrl,
      );
    });
  }
}
