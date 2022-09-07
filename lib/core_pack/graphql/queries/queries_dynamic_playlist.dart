import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';

class QueriesDynamicPlayList {
  static String getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument) {
    return '''
      mutation {
        getDynamicPlaylists(playlistInput: ${argument.toGraphqlPlaylistInput()}) {
          data {
            name
            source
            serviceName
            list {
              hotelId
              hotelName
              address {
                cityId
                locationName
                locationId
                address1
                cityName
                countryId
                countryName
              }
              rating
              review {
                description
                numReview
                score
              }
              promotion {
                promotionText
              }
              image
              adminPromotion {
                promotionText2
                promotionText1
                adminPromotionLine2
                adminPromotionLine1
              }
            }
          }
          status {
            code
            header
            description
            errors
          }
        }
      }
''';
  }
}
