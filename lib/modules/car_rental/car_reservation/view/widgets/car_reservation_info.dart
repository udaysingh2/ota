import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const int _kMaxLines = 1;

class CarReservationInfo extends StatelessWidget {
  final String? imageUrl;
  final String? headerText;
  final String? subHeaderText;
  final String? logo;

  const CarReservationInfo(
      {Key? key, this.imageUrl, this.headerText, this.subHeaderText, this.logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _getHeading(context),
        const SizedBox(
          height: kSize16,
        ),
        imageUrl != null ? _getImageCard() : _getDefaultImage(context),
        const SizedBox(
          height: kSize16,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerText ?? '',
                    style: AppTheme.kHeading1Medium,
                    maxLines: _kMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subHeaderText ?? '',
                    style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey50),
                    maxLines: _kMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: kSize8),
            _getLogoImage(),
          ],
        ),
      ],
    );
  }

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.yourReservation),
      style: AppTheme.kHeading1Medium,
      maxLines: _kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.contain,
          width: double.infinity,
          height: kSize152,
          errorWidget: (context, url, error) => _getDefaultImage(context),
          placeholder: (context, url) => _getDefaultImage(context)),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return SvgPicture.asset(_kPlaceholderImage,
        fit: BoxFit.cover, width: MediaQuery.of(context).size.width - kSize48);
  }

  Widget _getLogoImage() {
    String logoUrl = logo ?? '';
    return logoUrl.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.kBorderGrey,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  logoUrl,
                ),
                fit: BoxFit.contain,
              ),
            ),
            height: kSize40,
            width: kSize40,
          );
  }
}
