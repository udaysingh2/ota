import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/suggetion_view_model.dart';

const double _kContainerWidth = 240;
const _kSuggetionWidgetPadding = EdgeInsets.only(bottom: kSize24);
const _kTitleMaxLines = 1;

class SuggetionWidget extends StatelessWidget {
  final List<SuggetionViewModel> suggetionList;
  final Function(SuggetionViewModel)? onTap;
  const SuggetionWidget({Key? key, required this.suggetionList, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _kSuggetionWidgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            child: _getTitleBar(context),
          ),
          const SizedBox(
            height: kSize16,
          ),
          OtaPlayListAmenities(
            // shrinkWrap: true,
            // scrollDirection: Axis.horizontal,
            // itemCount: suggetionList.length,
            // padding: const EdgeInsets.symmetric(horizontal: kSize24),
            builder: (index) {
              return SizedBox(
                width: _kContainerWidth,
                child: OtaSuggestionCardHorizontalAmenities(
                  headerText: suggetionList[index].headerText ?? '',
                  ratingText: suggetionList[index].ratingText ?? '',
                  addressText: suggetionList[index].addressText ?? '',
                  ratingTitle: suggetionList[index].ratingTitle ?? '',
                  reviewText: suggetionList[index].reviewText ?? '',
                  offerPercent: suggetionList[index].offerPercent ?? '',
                  discount: suggetionList[index].discount ?? '',
                  imageUrl: suggetionList[index].imageUrl ?? '',
                  isInHorizontalScroll: true,
                  adminPromotionLine1:
                      suggetionList[index].adminPromotionLine1 ?? '',
                  adminPromotionLine2:
                      suggetionList[index].adminPromotionLine2 ?? '',
                  amenitiesList: suggetionList[index].amenitiesList,
                  onPress: () {
                    if (onTap == null) return;
                    onTap!(suggetionList[index]);
                  },
                ),
              );
            },
            // separatorBuilder: (BuildContext context, int index) {
            //   return const SizedBox(
            //     width: kSize12,
            //   );
            // },
            length: suggetionList.length,
          ),
        ],
      ),
    );
  }

  Widget _getTitleBar(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        getTranslated(context, AppLocalizationsStrings.accommodations),
        style: AppTheme.kHeading1Medium,
        maxLines: _kTitleMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
