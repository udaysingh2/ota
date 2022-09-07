import 'package:ota/domain/search/models/ota_search_argument.dart';

class QueriesOtaSearch {
  static String getOtaSearchData(OtaSearchDataArgument argument) {
    if (argument.tourAndTicketData != null && argument.carData != null) {
      return getOtaSearchWithAllData(argument);
    } else if (argument.tourAndTicketData != null) {
      return getOtaSearchWithTourData(argument);
    } else if (argument.carData != null) {
      return getOtaSearchWithCarData(argument);
    } else {
      return getOtaSearchOnlyHotelData(argument);
    }
  }

  static String getOtaSearchWithAllData(OtaSearchDataArgument argument) {
    return '''
            mutation GetOtaSearchResult {
              getOtaSearchResult(searchRequest : ${argument.toMap()})
              {
                data {
                  lastPageFlag
                  hotel {
                    filter {
                      minPrice
                      maxPrice
                      rating
                      promotion
                      reviewScore
                      adminPromotion
                      capsulePromotion {
                        name
                        code
                      }
                      infotechPromotion
                      availableHotel
                      sha
                    }
                    hotelList {
                      locationName
                      countryId
                      address
                      sortSequence
                      hotelStatus
                      hotelId
                      hotelName
                      hotelImage
                      rating
                      percentageDiscount
                      rackRate
                      rackRatePerNight
                      totalPrice
                      pricePerNight
                      ratingTitle
                      reviewText
                      offerPercent
                      discount
                      adminPromotionLine1
                      adminPromotionLine2
                      capsulePromotion {
                        name
                        code
                      }
                      review {
                        score
                        totalReview
                        reviewText
                      }
                      cityName
                      score
                      infotech11Promo
                    }
                  }
                  tourActivity {
                    filter {
                      minPrice
                      maxPrice
                      styleName
                    }
                    tourActivityList {
                      id
                      name
                      styleName
                      locationName
                      cityId
                      cityName
                      countryId
                      countryName
                      imageUrl
                      startPrice
                      promotionText_line1
                      promotionText_line2
                      capsulePromotion {
                        name
                        code
                      }
                    }
                  }
                  ticketActivity {
                    filter {
                      minPrice
                      maxPrice
                      styleName
                    }
                    ticketActivityList {
                      id
                      name
                      styleName
                      locationName
                      cityId
                      cityName
                      countryId
                      countryName
                      imageUrl
                      startPrice
                      promotionText_line1
                      promotionText_line2
                      capsulePromotion {
                        name
                        code
                      }
                    }
                  }
              carRental {
                pickupLocationId
                returnLocationId
                carModelList {
                  carId
                  brandId
                  brandName
                  suppliers {
                    pickupCounter {
                      locationId
                      address
                      name
                      description
                    }
                    returnCounter{
                         locationId
                      address
                      name
                      description
                    }
                  }
                  overlayPromotion {
                    adminPromotionLine1
                    adminPromotionLine2
                   }
                  modelName
                  images {
                    full
                    thumb
                  }
                  carInfo {
                    carTypeName
                    carTypeId
                  }
                  capsulePromotion {
                      name
                      code
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

  static String getOtaSearchWithCarData(OtaSearchDataArgument argument) {
    return '''
 mutation GetOtaSearchResult {
              getOtaSearchResult(searchRequest : ${argument.toMap()})
              {
                data {
                  lastPageFlag
                  hotel {
                    filter {
                      minPrice
                      maxPrice
                      rating
                      promotion
                      reviewScore
                      adminPromotion
                      capsulePromotion {
                        name
                        code
                      }
                      infotechPromotion
                      availableHotel
                      sha
                    }
                    hotelList {
                      locationName
                      countryId
                      address
                      sortSequence
                      hotelStatus
                      hotelId
                      hotelName
                      hotelImage
                      rating
                      percentageDiscount
                      rackRate
                      rackRatePerNight
                      totalPrice
                      pricePerNight
                      ratingTitle
                      reviewText
                      offerPercent
                      discount
                      adminPromotionLine1
                      adminPromotionLine2
                      capsulePromotion {
                        name
                        code
                      }
                      review {
                        score
                        totalReview
                        reviewText
                      }
                      cityName
                      score
                      infotech11Promo
                    }
                  }
                  carRental {
                    pickupLocationId
                    returnLocationId
                carModelList {
                  carId
                  brandId
                  brandName
                  suppliers {
                    pickupCounter {
                      locationId
                      address
                      name
                      description
                    }
                    returnCounter{
                         locationId
                      address
                      name
                      description
                    }
                  }
                  overlayPromotion {
                    adminPromotionLine1
                    adminPromotionLine2
                  }
                  modelName
                  images {
                    full
                    thumb
                  }
                  carInfo {
                    carTypeName
                    carTypeId
                  }
                  capsulePromotion {
                      name
                      code
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

  static String getOtaSearchWithTourData(OtaSearchDataArgument argument) {
    return '''
            mutation GetOtaSearchResult {
              getOtaSearchResult(searchRequest : ${argument.toMap()})
              {
                data {
                  lastPageFlag
                  hotel {
                    filter {
                      minPrice
                      maxPrice
                      rating
                      promotion
                      reviewScore
                      adminPromotion
                      capsulePromotion {
                        name
                        code
                      }
                      infotechPromotion
                      availableHotel
                      sha
                    }
                    hotelList {
                      locationName
                      countryId
                      address
                      sortSequence
                      hotelStatus
                      hotelId
                      hotelName
                      hotelImage
                      rating
                      percentageDiscount
                      rackRate
                      rackRatePerNight
                      totalPrice
                      pricePerNight
                      ratingTitle
                      reviewText
                      offerPercent
                      discount
                      adminPromotionLine1
                      adminPromotionLine2
                      capsulePromotion {
                        name
                        code
                      }
                      review {
                        score
                        totalReview
                        reviewText
                      }
                      cityName
                      score
                      infotech11Promo
                    }
                  }
                  tourActivity {
                    filter {
                      minPrice
                      maxPrice
                      styleName
                    }
                    tourActivityList {
                      id
                      name
                      styleName
                      locationName
                      cityId
                      cityName
                      countryId
                      countryName
                      imageUrl
                      startPrice
                      promotionText_line1
                      promotionText_line2
                      capsulePromotion {
                        name
                        code
                      }
                    }
                  }
                  ticketActivity {
                    filter {
                      minPrice
                      maxPrice
                      styleName
                    }
                    ticketActivityList {
                      id
                      name
                      styleName
                      locationName
                      cityId
                      cityName
                      countryId
                      countryName
                      imageUrl
                      startPrice
                      promotionText_line1
                      promotionText_line2
                      capsulePromotion {
                        name
                        code
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

  static String getOtaSearchOnlyHotelData(OtaSearchDataArgument argument) {
    return '''
            mutation GetOtaSearchResult {
              getOtaSearchResult(searchRequest : ${argument.toMap()})
              {
                data {
                  lastPageFlag
                  hotel {
                    filter {
                      minPrice
                      maxPrice
                      rating
                      promotion
                      reviewScore
                      adminPromotion
                      capsulePromotion {
                        name
                        code
                      }
                      infotechPromotion
                      availableHotel
                      sha
                    }
                    hotelList {
                      locationName
                      countryId
                      address
                      sortSequence
                      hotelStatus
                      hotelId
                      hotelName
                      hotelImage
                      rating
                      percentageDiscount
                      rackRate
                      rackRatePerNight
                      totalPrice
                      pricePerNight
                      ratingTitle
                      reviewText
                      offerPercent
                      discount
                      adminPromotionLine1
                      adminPromotionLine2
                      capsulePromotion {
                        name
                        code
                      }
                      review {
                        score
                        totalReview
                        reviewText
                      }
                      cityName
                      score
                      infotech11Promo
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
