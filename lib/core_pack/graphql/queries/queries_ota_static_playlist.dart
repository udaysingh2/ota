import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';

const String _kTourKey = "tour_key";
const String _kHotelKey = "hotel_key";
const String _kCarKey = "car_key";

class QueriesOtaStaticPlaylistData {
  static String getOtaStaticPlayList(
      StaticPlaylistArgumentDomain argumentModel) {
    if (argumentModel.enabledServices.contains(_kTourKey) &&
        argumentModel.enabledServices.contains(_kHotelKey) &&
        argumentModel.enabledServices.contains(_kCarKey)) {
      return '''
  mutation 
  {
    getPlaylists_v2(
      playlistInput_v2:  ${argumentModel.toMap()}) {
      data {
        serviceName
        language
        playlist {
          playlistId
          playlistName
          cardList {
        productType
        hotel {
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
        tour {
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
        carrental {
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
          craftType
          pickupLocationId
          returnLocationId
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
        ticket {
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
    status {
        code
        header
        description
      }
    }
  }
    ''';
    } else if (argumentModel.enabledServices.contains(_kTourKey) &&
        argumentModel.enabledServices.contains(_kHotelKey)) {
      return '''
  mutation 
  {
    getPlaylists_v2(
      playlistInput_v2:  ${argumentModel.toMap()}) {
      data {
        serviceName
        language
        playlist {
          playlistId
          playlistName
          cardList {
        productType
        hotel {
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
        tour {
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
        ticket {
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
    status {
        code
        header
        description
      }
    }
  }
    ''';
    } else if (argumentModel.enabledServices.contains(_kCarKey) &&
        argumentModel.enabledServices.contains(_kHotelKey)) {
      return '''
  mutation 
  {
    getPlaylists_v2(
      playlistInput_v2:  ${argumentModel.toMap()}) {
      data {
        serviceName
        language
        playlist {
          playlistId
          playlistName
          cardList {
        productType
        hotel {
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
        carrental {
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
          craftType
          pickupLocationId
          returnLocationId
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
    status {
        code
        header
        description
      }
    }
  }
    ''';
    }

    return '''
  mutation 
  {
    getPlaylists_v2(
      playlistInput_v2:  ${argumentModel.toMap()}) {
      data {
        serviceName
        language
        playlist {
          playlistId
          playlistName
          cardList {
        productType
        hotel {
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
    status {
        code
        header
        description
      }
    }
  }
    ''';
  }
}
