import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';

class QueriesHotelStaticPlayList {
  static String getHotelStaticPlayList(
      HotelStaticPlayListArgumentModelDomain argument) {
    return """ 
 mutation GetPlaylists {
  getPlaylists(
    playlistInput: ${argument.toGraphqlPlaylistInput()}
  ) {
    staticPlaylist {
      source
      serviceName
      playlist {
        playlistId
        playlistName
        cardList {
          id
          cityId
          countryId
          imageUrl
          countryName
          name
          locationName
          locationId
          cityName
          styleName
          startPrice
          productType
          address
          address1
          rating
          review {
            score
            numReview
            description
          }
          promotionText_line1
          promotionText_line2
          capsulePromotion {
            name
            code
          }
          infopromotion {
            promotionText
          }
        }
      }
    }
  }
}
""";
  }
}
