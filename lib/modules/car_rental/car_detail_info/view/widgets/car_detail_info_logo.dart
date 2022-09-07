import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class CarDetailInfoLogo extends StatelessWidget {
  final String imageUrl;
  final String text;
  const CarDetailInfoLogo(
      {Key? key, required this.imageUrl, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getLogInfo();
  }

  Widget _getLogInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.kBorderGrey,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.contain,
              ),
            ),
            height: kSize40,
            width: kSize40,
          ),
          const SizedBox(
            width: kSize12,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTheme.kBodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
