import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import '../../view_model/ota_search_view_model.dart';

const _kSuggestionWidgetPadding = EdgeInsets.only(bottom: kSize24);
const _kMaxLines = 1;

class OTASearchResultHorizontalWidget extends StatelessWidget {
  final List<HotelListResult>? cardList;
  final String title;
  final void Function()? onTitleArrowClick;
  final Function(String) onCardClick;

  const OTASearchResultHorizontalWidget({
    Key? key,
    this.cardList,
    required this.title,
    this.onTitleArrowClick,
    required this.onCardClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _kSuggestionWidgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kSize24),
            child: _getTitleBar(context, title),
          ),
          const SizedBox(
            height: kSize16,
          ),
          OtaPlayListAmenities(
            builder: (index) {
              return OtaSuggestionCardHorizontalAmenities(
                key: const Key('AmenitiesButton'),
                onPress: () {
                  onCardClick(cardList![index].hotelId!);
                },
                headerText: cardList?[index].hotelName ?? '',
                ratingText: cardList?[index].rating.toString() ?? '',
                score: cardList?[index].score ?? '',
                addressText: cardList?[index].address ?? '',
                ratingTitle: cardList?[index].ratingTitle ?? '',
                reviewText: cardList?[index].reviewText != null
                    ? '${cardList?[index].reviewText} ${getTranslated(context, AppLocalizationsStrings.review)}'
                    : '',
                offerPercent: cardList?[index].offerPercent ?? '',
                discount: cardList?[index].discount ?? '',
                imageUrl: cardList?[index].hotelImage ?? '',
                adminPromotionLine1: cardList?[index].adminPromotionLine1 ?? '',
                adminPromotionLine2: cardList?[index].adminPromotionLine2 ?? '',
                amenitiesList: cardList?[index].capsulePromotions ?? [],
              );
            },
            length: cardList?.length ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _getTitleBar(BuildContext context, String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTheme.kHeading1Medium,
            maxLines: _kMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        OtaNextButton(onPress: onTitleArrowClick),
        const SizedBox(width: kSize8),
      ],
    );
  }
}
