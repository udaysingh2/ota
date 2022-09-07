import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import '../../../../../common/utils/app_theme.dart';
import '../../../../../common/utils/consts.dart';
import '../../../../../core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_horizontal_playlist_amenities.dart';
import '../../../../../core_pack/custom_widgets/ota_next_button.dart';
import '../../../../../domain/search/models/ota_search_model.dart';
import 'ota_ammenities_widget.dart';

const double _kContainerHeight = 230;
const _kSuggestionWidgetPadding = EdgeInsets.only(bottom: kSize24);
const _kMaxLines = 1;
const String _kIconPlaceholder =
    'assets/images/illustrations/car_list_placeholder.png';

class OtaSearchHorizontalList extends StatelessWidget {
  const OtaSearchHorizontalList(
      {Key? key,
      required this.title,
      required this.dataList,
      this.onTitleArrowClick,
      required this.onCardClick})
      : super(key: key);

  final String title;
  final List<CarModelList>? dataList;
  final void Function()? onTitleArrowClick;
  final Function(CarModelList) onCardClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _kSuggestionWidgetPadding,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kSize24),
            child: _getTitleBar(context, title),
          ),
          const SizedBox(
            height: kSize16,
          ),
          SizedBox(
              height: _kContainerHeight,
              child: OtaHorizontalPlayListAmenities(
                builder: (index) {
                  return OtaSuggestionCardAmenities(
                    key: const Key('CarListButton'),
                    placeholderImage: _kIconPlaceholder,
                    isDefaultSvg: false,
                    headerText:
                        "${dataList![index].brandName!} ${dataList![index].modelName!}",
                    amenitiesList: dataList![index].capsulePromotion != null
                        ? dataList![index]
                            .capsulePromotion!
                            .map((e) => e.name ?? "")
                            .toList()
                        : [],
                    onPress: () {
                      onCardClick.call(dataList![index]);
                    },
                    description:
                        '${dataList![index].carInfo?.carTypeName?.trim() ?? ""}'
                        '${" "}${getTranslated(context, AppLocalizationsStrings.orSimilar)}',
                    adminPromotionLine1: dataList![index]
                            .overlayPromotion
                            ?.adminPromotionLine1 ??
                        '',
                    adminPromotionLine2: dataList![index]
                            .overlayPromotion
                            ?.adminPromotionLine2 ??
                        '',
                    imageUrl: dataList![index].images?.thumb ?? "",
                  );
                },
                length: dataList?.length ?? 0,
              ))
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

class SearchData {
  final String title;
  final int carId;
  final Icon icon;
  final String description;
  final List promotions;
  final String thumbUrl;

  SearchData(
      {required this.title,
      required this.icon,
      required this.carId,
      required this.description,
      required this.promotions,
      required this.thumbUrl});
}
