import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/profile_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/rating_count_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/review_view_model.dart';

const double _kReviewWidgetContainerHeight = 219;
const double _kReviewWidgetContainerWidth = 326;
const _kReviewWidgetPadding = EdgeInsets.only(bottom: kSize24);
const int _kCommentMaxLines = 1;

class ReviewWidget extends StatelessWidget {
  final List<ReviewViewModel>? reviewList;
  const ReviewWidget({Key? key, required this.reviewList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviewList != null && reviewList!.isNotEmpty) {
      return Padding(
        padding: _kReviewWidgetPadding,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: kSize24),
              child: _getTitleBar(context),
            ),
            const SizedBox(
              height: kSize16,
            ),
            SizedBox(
              height: _kReviewWidgetContainerHeight,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: reviewList!.length,
                padding: const EdgeInsets.symmetric(horizontal: kSize24),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: _kReviewWidgetContainerWidth,
                    child: Card(
                      margin: kPaddingHor0,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(kSize12)),
                          side: BorderSide(
                              color: AppColors.kBorderGrey, width: kSize1)),
                      elevation: kSize0,
                      child: Padding(
                        padding: kPaddingAll16,
                        child: buildReviewColumn(index),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: kSize8,
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getTitleBar(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Text(
          getTranslated(context, AppLocalizationsStrings.review),
          style: AppTheme.kHeading3,
        ),
      ),
      InkWell(
        borderRadius: BorderRadius.circular(kSize40),
        child: Ink(
          height: kSize40,
          width: kSize40,
          child: Center(
            child: SvgPicture.asset(
              "assets/images/icons/arrow_right.svg",
              width: kSize24,
              height: kSize24,
            ),
          ),
        ),
        onTap: () {},
      ),
      const SizedBox(
        width: kSize8,
      ),
    ]);
  }

  Column buildReviewColumn(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingCountWidget(
              rating: reviewList![index].rating,
            ),
            if (reviewList![index].date != null)
              Text(
                reviewList![index].date!,
                style: AppTheme.kSmall1,
              ),
          ],
        ),
        const SizedBox(
          height: kSize18,
        ),
        if (reviewList![index].comment != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              reviewList![index].comment!,
              style: AppTheme.kBody,
              maxLines: _kCommentMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (reviewList![index].comment != null)
          const SizedBox(
            height: kSize16,
          ),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        ProfileWidget(
          name: reviewList![index].profileName,
          date: reviewList![index].profileDate,
          roomType: reviewList![index].profileRoomType,
          citizen: reviewList![index].profileCitizen,
          imageUrl: reviewList![index].profileImageUrl,
          travelType: reviewList![index].profileTravelType,
        )
      ],
    );
  }
}
