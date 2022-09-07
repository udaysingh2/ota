import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kIconPlaceholder = 'assets/images/icons/addon_service_placeholder.svg';

class CarDetailMoreInfoLogo extends StatelessWidget {
  final String imageUrl;
  final String text;
  const CarDetailMoreInfoLogo(
      {Key? key, required this.imageUrl, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getLogInfo();
  }

  Widget _getLogInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: kSize24, top: kSize24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: kSize40,
            height: kSize40,
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitWidth,
                width: kSize40,
                height: kSize40,
                errorWidget: (context, url, error) => _getDefaultImages(),
                placeholder: (context, url) => _getDefaultImages()),
          ),
          const SizedBox(
            width: kSize12,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTheme.kHBody,
            ),
          )
        ],
      ),
    );
  }

  Widget _getDefaultImages() {
    return SvgPicture.asset(
      _kIconPlaceholder,
      width: kSize40,
      height: kSize40,
      fit: BoxFit.fill,
    );
  }
}
