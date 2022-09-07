import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/slider_gallery_button.dart';

const double _kPaddingOnElement = 15;
const double _kOverflowBorderValue = 1;
const double _kGalleryButtonPadding = 10;

class HotelSliderBottom extends StatelessWidget {
  final StatusBarBloc statusBarBloc;
  final PageController pageController;
  final double detailsBorder;
  final Function()? onGalleryClicked;
  final int sliderItemCount;
  final String galleryButtonText;
  const HotelSliderBottom(
      {Key? key,
      required this.statusBarBloc,
      required this.pageController,
      this.onGalleryClicked,
      required this.sliderItemCount,
      required this.galleryButtonText,
      required this.detailsBorder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget wrapInStatusBarBloc({required Widget child}) {
      return BlocBuilder(
          bloc: statusBarBloc,
          builder: () {
            if (statusBarBloc.state.statusBarBlocState ==
                StatusBarBlocState.closing) {
              return const SizedBox();
            }
            return child;
          });
    }

    return Column(
      children: [
        wrapInStatusBarBloc(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: _kGalleryButtonPadding),
              child: SliderGalleryButton(
                onRatingClicked: onGalleryClicked,
                buttonText: galleryButtonText,
              ),
            ),
          ),
        ),
        wrapInStatusBarBloc(
          child: const SizedBox(
            height: _kPaddingOnElement,
          ),
        ),
        Container(
          height: detailsBorder + 1,
          transform: Matrix4.translationValues(
              Offset.zero.dx, _kOverflowBorderValue, Offset.zero.dy),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(detailsBorder),
              topLeft: Radius.circular(detailsBorder),
            ),
          ),
        ),
      ],
    );
  }
}
