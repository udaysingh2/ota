import 'package:ota/core/query_names.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

class QueriesHotel {
  static String getHotelDetailData(HotelDetailDataArgument argument) {
    var roomsQuery = argument.rooms.map((result) => result.toMap()).toList();
    return '''
          mutation {
            ${QueryNames.shared.getHotelDetails}(
              hotelRequest: {
                hotelId: "${argument.hotelId}"
                cityId: "${argument.cityId}"
                checkInDate: "${argument.checkInDate}"
                checkOutDate: "${argument.checkOutDate}"
                currency: "${argument.currency}"
                countryId: "${argument.countryId}"
                room: $roomsQuery
              }
            ) {
              data {
                id
                name
                rating
                freefoodDelivery 
                ratingCount
                ratingText
                location
                address
                isFavourite
                images {
                 baseUri
                  cover
                  galleryCount
                  gallery
                }
                facilities {
                  list {
                    key
                    value
                  }
                  main {
                    key
                    value
                  }
                }
                promotionList {
                  title
                  description
                  web
                  iconImage
                  bannerDescDisplay
                  line1
                  line2
                  productId
                  productType
                  promotionType
                }
                rooms {
                  roomName
				          roomInfo {
                    roomFacilityInfo
                    coverImage
                    description
                    promoteFlag
                    dimension
                    totalRoom
                    doubleBedFlag
                    twinBedFlag
                    queenBedflag
                    smorkingFlag
                    nonSmorkingFlag
                    noWindowFlag
                    balconyFlag
                    wifiFlag
                    maxPaxNbr
                    roomFacilities {
                      code
                      name
                    }
				          }
                  facility {
                    key
                    value
                  }
                  details {
                    roomCode
                    roomCatName
                    roomOfferName
                    roomType
                    nightPrice
					          noOfRoomsAndName
					          nightPriceBeforeDiscount
					          discountPercent
                    totalPrice
                    roomOffer {
                      mealCode
                      breakfast
                      payNow
                      cancellationPolicy
                    }
                    hotelBenefits {
                      topic
                      shortDescription
                      longDescription
                      categoryId
                      categoryName
                    }
                    supplier
                    supplierId
                    supplierName
                  }
                }
              }
              status {
                code
                header
              }
              metadata {
                source
                timeStamp
              }
            }
          }
    ''';
  }

  static String getHotelGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) {
    return '''
          mutation{
            getImages(
              hotelId: "${argument.hotelId}"
              cityId: "${argument.cityId}"
              checkInDate: "${argument.checkInDate}"
              checkOutDate: "${argument.checkOutDate}"
              currency: "${argument.currency}"
              countryId: "${argument.countryId}"
              galleryOffset: "$offset",
              galleryLimit: "$limit"
            ) {
              data {
                images {
                  baseUri
                  gallery
                }
              }
              status {
                code
                header
              }
            }
          }
    ''';
  }

  static String checkFavorites(String type, String hotelId) {
    return '''
          query{
            checkFavorites(
              serviceName: "$type", 
              hotelId: "$hotelId"
              ){
                data {
                  isFavorite
                }
                status{
                  code
                  header
                }
              }
            }
    ''';
  }

  static String addFavourite(
      AddFavoriteArgumentModelDomain favoriteArgumentModel) {
    return '''
          mutation {
            addFavorite(
              addFavoriteRequest: {
                serviceName:"HOTEL"
                hotelId: "${favoriteArgumentModel.hotelId}"
                cityId: "${favoriteArgumentModel.cityId}"
                countryId: "${favoriteArgumentModel.countryId}"
                hotelName: "${favoriteArgumentModel.hotelName}"
                latitude: null
                longitude: null
                location: "${favoriteArgumentModel.location}"
                hotelImage: "${favoriteArgumentModel.hotelImage}"
              }   
            ) {
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
