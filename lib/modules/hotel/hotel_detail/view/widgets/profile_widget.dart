import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const int _kMaxLines = 1;
const double _kCircleAvatarRadius = 2;

class ProfileWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String? date;
  final String? roomType;
  final String? citizen;
  final String? travelType;
  const ProfileWidget(
      {Key? key, required this.name,
      this.date,
      this.roomType,
      this.citizen,
      this.travelType,
      this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kSize16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (imageUrl != null)
            Flexible(
              child: CircleAvatar(
                radius: kSize15,
                backgroundImage: NetworkImage(imageUrl!),
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: kSize8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey70),
                    maxLines: _kMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: kSize5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (date != null)
                        Text(
                          date!,
                          style: AppTheme.kSmall2,
                          maxLines: _kMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (date != null)
                        const SizedBox(
                          width: kSize4,
                        ),
                      if (date != null)
                        const CircleAvatar(
                          radius: _kCircleAvatarRadius,
                          backgroundColor: AppColors.kGrey50,
                        ),
                      const SizedBox(
                        width: kSize4,
                      ),
                      if (roomType != null)
                        Expanded(
                          child: Text(
                            roomType!,
                            style: AppTheme.kSmall2,
                            maxLines: _kMaxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: kSize5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (citizen != null)
                        Text(
                          citizen!,
                          style: AppTheme.kSmall2,
                          maxLines: _kMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (citizen != null)
                        const SizedBox(
                          width: kSize4,
                        ),
                      if (citizen != null)
                        const CircleAvatar(
                          radius: _kCircleAvatarRadius,
                          backgroundColor: AppColors.kGrey50,
                        ),
                      const SizedBox(
                        width: kSize4,
                      ),
                      if (travelType != null)
                        Expanded(
                          child: Text(
                            travelType!,
                            style: AppTheme.kSmall2,
                            maxLines: _kMaxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
