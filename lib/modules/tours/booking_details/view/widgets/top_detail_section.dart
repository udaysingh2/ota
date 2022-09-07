import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const _kTourIcon = 'assets/images/icons/tour_icon.svg';
const _kTicketIcon = 'assets/images/icons/uil_ticket.svg';
const _kTourType = 'tour';
const _kTicketType = 'ticket';
const _kCarType = 'car';
const _kFlightType = 'flight';

class OtaTopDetailsSection extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String? categoryName;
  final String? categoryLocation;
  final String? subTitle;
  final String serviceType;

  const OtaTopDetailsSection(
      {Key? key,
      required this.title,
      this.imageUrl,
      this.categoryName,
      this.categoryLocation,
      this.subTitle,
      required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageUrl != null ? _getImageCard() : _getDefaultImage(context),
        const SizedBox(
          height: kSize16,
        ),
        if (subTitle != null) Text(subTitle!, style: AppTheme.kHBody),
        if (subTitle != null) const SizedBox(height: kSize4),
        Text(
          title,
          style: AppTheme.kHeading1Medium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (_getCategoryLocation() != null) const SizedBox(height: kSize4),
        Row(
          children: [
            if (categoryName != null) _getSvgIcon(serviceType),
            if (categoryName != null) const SizedBox(width: kSize4),
            if (_getCategoryLocation() != null)
              _getTextView(_getCategoryLocation()!),
          ],
        ),
        const SizedBox(height: kSize16),
      ],
    );
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          height: kSize152,
          width: double.infinity,
          errorWidget: (context, url, error) => _getDefaultImage(context),
          placeholder: (context, url) => _getDefaultImage(context)),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return SvgPicture.asset(
      _kPlaceholderImage,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width - kSize48,
      height: kSize152,
    );
  }

  String? _getCategoryLocation() {
    String? text;
    if (categoryName != null && categoryLocation != null) {
      text = categoryName!.addTrailingDot() + categoryLocation!;
    } else if (categoryName != null) {
      text = categoryName;
    } else if (categoryLocation != null) {
      text = categoryLocation;
    }
    return text;
  }

  Widget _getTextView(String text) {
    return Text(
      text,
      style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
    );
  }

  Widget _getSvgIcon(String type) {
    String iconName = "";
    switch (type) {
      case _kTourType:
        iconName = _kTourIcon;
        break;
      case _kTicketType:
        iconName = _kTicketIcon;
        break;
      case _kCarType:
        iconName = _kTourIcon; //change with car icon
        break;
      case _kFlightType:
        iconName = _kTourIcon; //change with flight icon
        break;
      default:
        iconName = _kTourIcon; //get the default icon
    }
    return SvgPicture.asset(
      iconName,
      height: kSize16,
      width: kSize16,
      fit: BoxFit.contain,
      color: AppColors.kGrey50,
    );
  }
}
