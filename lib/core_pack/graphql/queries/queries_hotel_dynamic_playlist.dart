import '../../../domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';

class QueriesHotelDynamicPlayList {
  static String getDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain argument) {
    return ''' 
        mutation GetRecentViewPlaylist {
          getRecentViewPlaylist(
            playlistInput: ${argument.toGraphqlDynamicPlaylistInput()}
          ) {
            recentViewPlaylist {
              hotelId
              cityId
              countryId
              rating
              hotelName
              image
              locationName
              promotionList {
                productId
                productType
                promotionType
                promotionCode
                line1
                line2
                startDate
                endDate
                name
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
                  infoPromotion
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
