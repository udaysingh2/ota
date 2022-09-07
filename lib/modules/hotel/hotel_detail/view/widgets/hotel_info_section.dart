import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';

const double _kHotelInfoPadding = 24;
const double _kOpacityMax = 1;
const double _kOpacityMin = 0;
const _kAnimationDuration = 200;
const double _kPaddingHorizontal = 8;
const int _kMaxLines = 1;
const int _kMaxLines2 = 2;

class HotelInfoSection extends StatelessWidget {
  final StatusBarBloc statusBarBloc;
  final String? headerText;
  final String? ratingText;
  final String? addressText;
  final String? ratingIndexText;
  final String? ratingIndexDescriptionText;
  final String? ratingButtonText;

  const HotelInfoSection(
      {Key? key,
      required this.statusBarBloc,
      this.headerText,
      this.addressText,
      this.ratingIndexText,
      this.ratingIndexDescriptionText,
      this.ratingButtonText,
      this.ratingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: _kHotelInfoPadding, right: _kHotelInfoPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder(
              bloc: statusBarBloc,
              builder: () {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: _kAnimationDuration),
                  opacity: statusBarBloc.state.statusBarBlocState ==
                          StatusBarBlocState.opened
                      ? _kOpacityMax
                      : _kOpacityMin,
                  child: Text(
                    headerText ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.kHeading1Medium,
                    maxLines: _kMaxLines2,
                  ),
                );
              }),
          Row(
            children: [
              if (ratingText != null)
                OtaStarRating(
                  starRating:
                      (double.tryParse(ratingText ?? "1")?.floor() ?? 1),
                  forceToOne: true,
                ),
              if (ratingText != null)
                const SizedBox(
                  width: _kPaddingHorizontal,
                ),
              Expanded(
                child: Text(
                  addressText ?? "",
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                  maxLines: _kMaxLines,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget getReviewSection() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: _kPaddingHorizontal),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Row(
  //             children: [
  //               RatingTile(
  //                 text: ratingIndexText ?? "",
  //               ),
  //               const SizedBox(
  //                 width: _kSpacing5,
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   ratingIndexDescriptionText ?? "",
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: AppTheme.kHBody.copyWith(
  //                     color: AppColors.kSecondary,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         InkWell(
  //           onTap: onSeeReviewClicked,
  //           child: Ink(
  //             color: Colors.transparent,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   ratingButtonText ?? "",
  //                   style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey70),
  //                 ),
  //                 SvgPicture.asset("assets/images/icons/chevron_right.svg"),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
