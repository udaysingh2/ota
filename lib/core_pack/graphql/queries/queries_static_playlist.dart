class QueriesStaticPlayList {
  static String getStaticPlayListData() {
    return '''
      mutation {
        getStaticPlaylists {
          data {
            serviceName
            source
            playList {
              name
              list {
                hotelId
                hotelName
                rating
                image
                address {
                  address1
                  locationId
                  locationName
                  cityId
                  cityName
                  countryId
                  countryName
                }
                review {
                  score
                  numReview
                  description
                }
                promotion {
                  promotionText
                }
                adminPromotion {
                  adminPromotionLine1
                  adminPromotionLine2
                  promotionText2
                  promotionText1
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
