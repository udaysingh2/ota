import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating_controller.dart';

const double _kDefaultSize = 16;
const int _kDefaultRating = 0;
const double _kDefaultSpacing = 0;

class OtaStarRating extends StatelessWidget {
  final int starRating;
  final double spacing;
  final double size;
  final bool forceToOne;
  final OtaStarRatingController? otaStarRatingController;
  const OtaStarRating(
      {Key? key,
      this.starRating = _kDefaultRating,
      this.otaStarRatingController,
      this.spacing = _kDefaultSpacing,
      this.forceToOne = true,
      this.size = _kDefaultSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (otaStarRatingController != null) {
      if (forceToOne) {
        otaStarRatingController
            ?.updateStarRating(starRating <= 0 ? 1 : starRating);
      } else {
        otaStarRatingController?.updateStarRating(starRating);
      }
    }
    return SizedBox(
      height: size,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return getStar();
        },
        itemCount: otaStarRatingController?.state.starCount ?? starRating,
      ),
    );
  }

  Widget getStar() {
    return Padding(
      padding: EdgeInsets.only(right: spacing),
      child: SvgPicture.asset(
        "assets/images/icons/star.svg",
        height: size,
        width: size,
      ),
    );
  }
}
