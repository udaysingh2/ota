import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_chip_button/tour_chip_button.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

double height = 0;
const double _kRowHeight = 29;
const int _kItemCount = 2;
const double _kRunSpacing = kSize8;
const int _kNoOfRows = 3;
const double _kStyleHeight =
    ((_kRowHeight * _kNoOfRows) + (_kRunSpacing * (_kNoOfRows - 1)) + kSize2);

class TourLiveWrapViewWidget extends StatefulWidget {
  final List<TourStyleViewModel>? styleList;
  final Function() getMoreView;
  final Function(Widget widget) getStyleView;

  const TourLiveWrapViewWidget(
      {Key? key,
      required this.styleList,
      required this.getMoreView,
      required this.getStyleView})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TourLiveWrapViewWidgetState();
}

class _TourLiveWrapViewWidgetState extends State<TourLiveWrapViewWidget>
    with AutomaticKeepAliveClientMixin<TourLiveWrapViewWidget> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: const EdgeInsets.only(top: kSize8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _kItemCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return widget.getStyleView(Wrap(
            key: _key,
            spacing: kSize8,
            runSpacing: kSize8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: _getStyleList(),
          ));
        } else {
          if (_getHeight() >= _kStyleHeight) {
            return widget.getMoreView();
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );
  }

  List<Widget> _getStyleList() {
    List<Widget> chipButtonList = [];
    for (TourStyleViewModel tourStyle in widget.styleList!) {
      chipButtonList.add(TourChipButton(filterStyle: tourStyle));
    }
    return chipButtonList;
  }

  double _getHeight() {
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    if (height == 0) {
      height = size.height;
    }
    return height;
  }

  @override
  bool get wantKeepAlive => true;
}
