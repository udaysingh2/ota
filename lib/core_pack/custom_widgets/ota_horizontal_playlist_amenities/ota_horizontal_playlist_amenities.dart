import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';

import 'ota_horizontal_playlist_controller.dart';

const double _kWidth = 240;
const double _kSeparatorWidth = 12;
const int _kLastIndex = 1;

class OtaHorizontalPlayListAmenities extends StatefulWidget {
  const OtaHorizontalPlayListAmenities(
      {Key? key,
      required this.builder,
      required this.length,
      this.width,
      this.listViewPadding = const EdgeInsets.symmetric(horizontal: kSize24)})
      : super(key: key);
  final Widget Function(int) builder;
  final int length;
  final double? width;
  final EdgeInsetsGeometry? listViewPadding;

  @override
  PlayListWidgetState createState() => PlayListWidgetState();
}

class PlayListWidgetState extends State<OtaHorizontalPlayListAmenities> {
  final OtaHorizontalPlayListController bloc =
      OtaHorizontalPlayListController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: () {
        return SizedBox(
          height: bloc.state.value,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.length,
                padding: widget.listViewPadding,
                itemBuilder: (context, index) {
                  final GlobalKey textKey = GlobalKey();
                  if (index == widget.length - _kLastIndex) {
                    bloc.updateState(textKey);
                  } else {
                    bloc.updateStateWithNoEmit(textKey);
                  }
                  return Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: widget.width ?? _kWidth,
                      key: textKey,
                      child: widget.builder(index),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: _kSeparatorWidth,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
