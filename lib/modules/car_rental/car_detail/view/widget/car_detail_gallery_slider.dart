import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_status_bar_bloc.dart';

const double _kBackgroundOpacity = 0.94;
const int _kMaxLine = 1;
const String _kCarDetailGalleryButtonKey = 'car_detail_gallery_button_key';

class CarDetailGallerySlider extends StatelessWidget {
  final CarDetailStatusBarBloc statusBarBloc;
  final Function()? onGalleryClicked;

  const CarDetailGallerySlider({
    Key? key,
    required this.statusBarBloc,
    this.onGalleryClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getGalleryButton(context),
        Container(
          height: kSize25,
          transform: Matrix4.translationValues(
            Offset.zero.dx,
            kSize1,
            Offset.zero.dy,
          ),
          decoration: const BoxDecoration(
            color: AppColors.kTrueWhite,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(kSize24),
              topLeft: Radius.circular(kSize24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getGalleryButton(BuildContext context) {
    return BlocBuilder(
      bloc: statusBarBloc,
      builder: () {
        if (statusBarBloc.state.statusBarBlocState ==
            CarDetailStatusBarState.closing) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(right: kSize10, bottom: kSize15),
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              key: const Key(_kCarDetailGalleryButtonKey),
              borderRadius: BorderRadius.circular(kSize20),
              onTap: onGalleryClicked,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSize20),
                  color: AppColors.kLight100.withOpacity(_kBackgroundOpacity),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: kSize8,
                  vertical: kSize4,
                ),
                child: Text(
                  getTranslated(context, AppLocalizationsStrings.galleryView),
                  textAlign: TextAlign.center,
                  style: AppTheme.kSmallRegular,
                  maxLines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
