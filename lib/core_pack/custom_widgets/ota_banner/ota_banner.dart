import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_custom_material_banner.dart';

const Duration _kAnimatedDuration = Duration(milliseconds: 100);

class OtaBanner {
  void showMaterialBanner(BuildContext context, String textmsg,
      Color backgroundColor, String iconString,
      {Widget? child,
      double? bannerHeight,
      CrossAxisAlignment? crossAxisAlignment}) {
    double customBannerHeight = (bannerHeight != null) ? bannerHeight : kSize54;
    CustomMaterialBannerBloc customMaterialBannerBloc =
        CustomMaterialBannerBloc();
    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return BlocBuilder(
          bloc: customMaterialBannerBloc,
          builder: () {
            return AnimatedPositioned(
              duration: _kAnimatedDuration,
              height: customBannerHeight + MediaQuery.of(context).padding.top,
              top: customMaterialBannerBloc.getTop(customBannerHeight),
              left: kSize0,
              width: MediaQuery.of(context).size.width,
              child: child ??
                  CustomMaterialBanner(
                    key: const Key("value"),
                    text: textmsg,
                    iconString: iconString,
                    backgroundColor: backgroundColor,
                    crossAxisAlignment: crossAxisAlignment,
                  ),
            );
          },
        );
      },
    );

    Overlay.of(context)?.insert(entry);
    customMaterialBannerBloc.showBanner(entry);
  }
}
