import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class CarDetailMoreInfoListingItem extends StatelessWidget {
  final String imageUrl;
  final String header;
  final List<String> subHeaders;
  const CarDetailMoreInfoListingItem(
      {Key? key,
      required this.imageUrl,
      required this.header,
      required this.subHeaders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTrianglerWidget();
  }

  Widget _getTrianglerWidget() {
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: kSize20,
                height: kSize20,
                child: SvgPicture.asset(
                  imageUrl,
                  width: kSize20,
                  height: kSize20,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: kSize4,
              ),
              Expanded(
                child: Text(
                  header,
                  style: AppTheme.kHBody,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: kSize24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getListOfItems(subHeaders),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _getListOfItems(List<String> items) {
    return List<Widget>.generate(items.length, (index) {
      return Text(
        items.elementAt(index),
        style: AppTheme.kSmall2,
      );
    });
  }
}
