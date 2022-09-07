import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';

class QueriesPlayList {
  static String getPlayListData(PlayListDataArgument argument) {
    return '''
    mutation {
    getPlaylists (
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
    dynamicPlaylist {
      source
      serviceName
      playlist {
        playlistId
        playlistName
        cardList {
          id
          cityId
          countryId
          countryName
          imageUrl
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
    ''';
  }

  static String getLandingStaticPlayListData(
      HotelLandingStaticSingleDataArgument argument) {
    return '''
  mutation GetPlaylists {
  getPlaylists(
    playlistInput: {
      lat: ${argument.lat}
      long: ${argument.long}
      epoch: ${argument.epoch}
      max: ${argument.max}
      offset: ${argument.offset}
      limit: ${argument.limit}
      playlistId: "${argument.playlistId}"
      source :"static"
      serviceName: "HOTEL"
    }
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


   
    ''';
  }

  static String getLandingDynamicPlayListData(
      HotelLandingDynamicSingleDataArgument argument) {
    return '''
  mutation GetPlaylists {
  getPlaylists(
    playlistInput: {
      lat: ${argument.lat}
      long: ${argument.long}
      epoch: ${argument.epoch}
      max: ${argument.max}
      offset: ${argument.offset}
      limit: ${argument.limit}
      playlistId: "${argument.playlistId}"
      source :"dynamic"
      serviceName: "HOTEL"
    }
  ) {
   
    dynamicPlaylist {
      source
      serviceName
      playlist {
        playlistId
        playlistName
        cardList {
          id
          cityId
          countryId
          countryName
          imageUrl
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


   
    ''';
  }
}
