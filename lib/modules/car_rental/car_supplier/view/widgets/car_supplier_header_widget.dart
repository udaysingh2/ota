import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_amentities_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kPlaceholderImage =
    'assets/images/illustrations/car_rental_default.png';
const double kSize98 = 98;
const int kMaxLines = 1;

class CarSupplierHeaderWidget extends StatelessWidget {
  final String? imageUrl;
  final String carName;
  final String brandName;
  final String craftType;
  final List<String> amenitiesList;
  const CarSupplierHeaderWidget(
      {Key? key,
      this.imageUrl,
      this.carName = '',
      this.brandName = '',
      this.craftType = '',
      this.amenitiesList = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: kSize98,
            height: kSize64,
            child:
                imageUrl != null ? _getImageCard() : _getDefaultImage(context),
          ),
          const SizedBox(width: kSize16),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _getName(
                  brandName.addTrailingSpace() + carName, AppTheme.kBodyMedium),
              _getName(
                  "$craftType ${getTranslated(context, AppLocalizationsStrings.orSimilar)}",
                  AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)),
              if (amenitiesList.isNotEmpty) KeyAmenitiesWidget(amenitiesList),
            ],
          )
        ],
      ),
    );
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.contain,
        width: double.infinity,
        errorWidget: (context, url, error) => _getDefaultImage(context),
        placeholder: (context, url) => _getDefaultImage(context),
      ),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: Image.asset(
        _kPlaceholderImage,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width - kSize48,
      ),
    );
  }

  Widget _getName(String name, TextStyle? textStyle, {int? maxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines ?? kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
