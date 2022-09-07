import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';

const double _kListContainerHeight = 146;
const double _kImageSize = 100;
const int _kMaxLines = 1;
const String _kServiceCardPlaceholder =
    "assets/images/icons/service_card_placeholder.svg";
const Color _kGradientStartColor = Color.fromRGBO(0, 0, 0, 0);
const Color _kGradientEdnColor = Color.fromRGBO(0, 0, 0, 0.5);
const Alignment _kGradientBegin = Alignment.topCenter;
const Alignment _kGradientEnd = Alignment.bottomCenter;

class HotelRecommendedLocationsWidget extends StatelessWidget {
  final String recommendedLocationTitle;
  final List<RecommendedLocationModel> recommendedLocationList;
  final Function(int)? onTap;

  const HotelRecommendedLocationsWidget({
    Key? key,
    required this.recommendedLocationTitle,
    required this.recommendedLocationList,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kListContainerHeight,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: kSize16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: kSize24),
              itemCount: recommendedLocationList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _buildRecommendationCard(
                    recommendedLocationList[index], index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: kSize12);
              },
            ),
          )
        ],
      ),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Text(
        recommendedLocationTitle,
        style: AppTheme.kHeading1Medium,
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildRecommendationCard(
      RecommendedLocationModel recommendationsModel, int index) {
    return Material(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(kSize12)),
        onTap: () {
          onTap != null ? onTap!(index) : null;
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(kSize12)),
              child: recommendationsModel.imageUrl != null &&
                      recommendationsModel.imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: recommendationsModel.imageUrl!,
                      fit: BoxFit.fill,
                      width: _kImageSize,
                      height: _kImageSize,
                      errorWidget: (context, string, dyn) {
                        return _buildPlaceholderImage();
                      },
                      placeholder: (context, str) {
                        return _buildPlaceholderImage();
                      },
                    )
                  : _buildPlaceholderImage(),
            ),
            Positioned(
              bottom: kSize0,
              child: Container(
                height: kSize37,
                width: _kImageSize,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kSize12),
                    bottomRight: Radius.circular(kSize12),
                  ),
                  gradient: LinearGradient(
                    begin: _kGradientBegin,
                    end: _kGradientEnd,
                    colors: [_kGradientStartColor, _kGradientEdnColor],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: kSize5,
              child: Container(
                width: _kImageSize,
                padding:
                    const EdgeInsets.fromLTRB(kSize8, kSize0, kSize8, kSize0),
                child: Text(
                  recommendationsModel.placeName,
                  style: AppTheme.kSmallMedium
                      .copyWith(color: AppColors.kTrueWhite),
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SvgPicture _buildPlaceholderImage() {
    return SvgPicture.asset(
      _kServiceCardPlaceholder,
      fit: BoxFit.cover,
      height: _kImageSize,
      width: _kImageSize,
    );
  }
}
