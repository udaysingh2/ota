import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_landing_page_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';

const _kSuggetionWidgetPadding = EdgeInsets.only(bottom: kSize24);
const _kTitleMaxLines = 1;
const String _kPlaylistSection = "OTA_landing";
const String _kTravelId = '1';
const String _kTravelName = 'hotel';

class LandingPlayListWidget extends StatelessWidget {
  final bool isStatic;
  final List<OtaLandingPlayListModel> playList;
  final void Function(String, String?)? onTitleArrowClick;
  const LandingPlayListWidget({
    Key? key,
    required this.playList,
    this.onTitleArrowClick,
    required this.isStatic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Widget>.generate(playList.length, (i) {
      return Padding(
        padding: _kSuggetionWidgetPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: kSize24),
              child: _getTitleBar(
                context,
                isStatic
                    ? playList[i].playlistName
                    : getTranslated(context,
                        AppLocalizationsStrings.recommendedAccomodation),
                isStatic ? playList[i].playlistId : null,
              ),
            ),
            const SizedBox(
              height: kSize16,
            ),
            OtaPlayListAmenities(
              builder: (index) {
                String headerText = playList[i].cardList[index].headerText;
                String hotelId = playList[i].cardList[index].hotelId;
                return (headerText.isEmpty || hotelId.isEmpty)
                    ? const SizedBox.shrink()
                    : OtaSuggestionCardHorizontalAmenities(
                        onPress: () {
                          _getPlaylistEvent(playList[i],
                              playList[i].cardList[index], context);
                          _navigateHotelDetail(
                              playList[i].cardList[index], context);
                        },
                        headerText: playList[i].cardList[index].headerText,
                        ratingText: playList[i].cardList[index].ratingText,
                        score: playList[i].cardList[index].score,
                        addressText: playList[i].cardList[index].locationName,
                        ratingTitle: playList[i].cardList[index].ratingTitle,
                        reviewText: playList[i]
                                .cardList[index]
                                .reviewText
                                .isNotEmpty
                            ? '${playList[i].cardList[index].reviewText} ${getTranslated(context, AppLocalizationsStrings.review)}'
                            : '',
                        offerPercent: playList[i].cardList[index].offerPercent,
                        discount: playList[i].cardList[index].discount,
                        imageUrl: playList[i].cardList[index].imageUrl,
                        adminPromotionLine1:
                            playList[i].cardList[index].adminPromotionLine1,
                        adminPromotionLine2:
                            playList[i].cardList[index].adminPromotionLine2,
                        amenitiesList: LandingPageHelper.getAmenitiesList(
                            playList[i].cardList[index].capsulePromotion,
                            playList[i].cardList[index].infoPromotion,
                            isStatic),
                      );
              },
              length: playList[i].cardList.length,
            ),
          ],
        ),
      );
    }));
  }

  void _navigateHotelDetail(
      PlaylistCardViewModel playlistCardViewModel, BuildContext context) {
    final hotelArgument = HotelDetailArgument.getDefaultArgumentForChannel(
      playlistCardViewModel.hotelId,
      playlistCardViewModel.cityId,
      playlistCardViewModel.countryId,
      getLoginProvider().userType.getHotelDetailType(),
    );
    Navigator.pushNamed(
      context,
      AppRoutes.hotelDetail,
      arguments: hotelArgument,
    );
  }

  Widget _getTitleBar(BuildContext context, String title, String? playlistId) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: AppTheme.kHeading1Medium,
          maxLines: _kTitleMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        OtaNextButton(onPress: () {
          onTitleArrowClick != null
              ? onTitleArrowClick!(title, playlistId)
              : onTitleArrowClick;
        }),
        const SizedBox(width: kSize8),
      ],
    );
  }

  List<String?>? _getAddOnItemName(List<PlaylistCardViewModel>? cardPlayList) {
    List<String?>? result;
    if (cardPlayList != null) {
      result = cardPlayList.map((e) => e.hotelId).toList();
    }
    return result;
  }

  void _getPlaylistEvent(OtaLandingPlayListModel? model,
      PlaylistCardViewModel? cardData, BuildContext context) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.playlistSection,
        value: _kPlaylistSection);
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.playlistId,
        value: model?.playlistId ?? '');

    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.travelId, value: _kTravelId);
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.travelName, value: _kTravelName);

    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.playlistName,
        value: isStatic
            ? model?.playlistName
            : getTranslated(
                context, AppLocalizationsStrings.recommendedAccomodation));
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.hotelId,
        value: cardData?.hotelId ?? '');
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.hotelName,
        value: cardData?.headerText ?? '');
    logger.addCommaSeparatedList(
        value: _getAddOnItemName(model?.cardList),
        key: OtaPlayListLandingFirebase.allIdSequence);
    logger.addUserLocation();
    logger.publishToSuperApp(FirebaseEvent.otaPlaylist);
  }
}
