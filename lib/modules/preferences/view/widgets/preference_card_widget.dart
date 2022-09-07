import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const int _kMaxLines = 2;
const String _kIconPlaceholder =
    'assets/images/icons/suggetion_card_palceholder.svg';
const String _kHeartIcon = "assets/images/icons/heart_selected.svg";
const double _kDefaultHeight = 144;
const double _kAspectRatio = 3 / 2;

class PreferenceCardWidget extends StatelessWidget {
  final double width;
  final double? height;
  final String? imageUrl;
  final String? description;
  final Function()? onClicked;
  final bool isSelected;
  const PreferenceCardWidget({
    Key? key,
    required this.width,
    this.onClicked,
    this.height = _kDefaultHeight,
    this.description,
    this.imageUrl,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: kBorderRad12,
      onTap: onClicked,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: kBorderRad12,
          color: AppColors.kLight100,
          border: Border.all(color: AppColors.kGrey4),
          boxShadow: const [
            BoxShadow(
              color: AppColors.kBlackOpacity4,
              blurRadius: kSize8,
              offset: Offset(kSize0, kSize4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: _kAspectRatio,
              child: Stack(
                children: [
                  SizedBox(height: height, child: _getImage()),
                  Offstage(
                    offstage: !isSelected,
                    child: Container(
                      width: width,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: AppColors.gradient1Opacity70,
                        borderRadius: AppTheme.kBorderRadiusTop12,
                      ),
                      child: SvgPicture.asset(
                        _kHeartIcon,
                        color: AppColors.kLight100,
                        height: kSize40,
                        width: kSize40,
                      ),
                    ),
                  )
                ],
              ),
            ),
            _getBottomText(),
          ],
        ),
      ),
    );
  }

  Widget _getImage() {
    return ClipRRect(
      borderRadius: AppTheme.kBorderRadiusTop12,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        fit: BoxFit.cover,
        width: width,
        placeholder: (context, url) => _getDefaultImage(),
        errorWidget: (context, url, error) => _getDefaultImage(),
      ),
    );
  }

  Widget _getDefaultImage() {
    return SvgPicture.asset(
      _kIconPlaceholder,
      fit: BoxFit.cover,
      width: width,
    );
  }

  Widget _getBottomText() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: kSize8),
        width: width,
        child: Text(
          description ?? "",
          style: AppTheme.kPreferenceDescriptionText,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
