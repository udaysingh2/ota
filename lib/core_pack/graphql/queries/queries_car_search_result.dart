import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_argument_model.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

class QueriesCarSearchResult {
  static String getCarSearchResultData(
    CarSearchResultDomainArgumentModel argument,
    int pageNumber,
    int pageSize,
    LocationModel? pickupLocation,
    LocationModel? dropLocation,
    String dataSearchType,
    bool isSearchSave,
  ) {
    return '''  
    mutation {
      getCarRentalSearchResult( searchRequest: {
        searchKey: "${argument.searchKey}",
        latitude: ${argument.latitude},
        longitude: ${argument.longitude},
        pageSize: $pageSize,
        pageNumber: $pageNumber,
        sortingMode: "${argument.sortingMode}",
        carRental: {
          searchAvailableApi: ${argument.searchAvailableApi},
          pickupLocationId: "${argument.pickupLocationId}",
          returnLocationId: "${argument.returnLocationId}",
          pickupLocationName:"${pickupLocation?.location}",
          returnLocationName:"${dropLocation?.location}",
          pickupDate: "${argument.pickupDate}",
          returnDate: "${argument.returnDate}",
          pickupTime: "${argument.pickupTime}",
          returnTime: "${argument.returnTime}",
          age: ${argument.age},
          dataSearchType: "$dataSearchType"
          includeDriver: ${argument.includeDriver},
          isSearchSave:$isSearchSave
          filter: {
            minPrice: ${argument.minPrice},
            maxPrice: ${argument.maxPrice},
            carType: ${argument.carType},
            carBrand: ${argument.carBrand},
            carSupplier: ${argument.toMap()},  
            capsulePromotion: null,
          }
        }
      }
) {
    data {
      carRental {
       pickupLocationId
       returnLocationId
        carModelList {
          carId
          sortSequence
          brandId  
          brandName  
          modelName
          carInfo {
            carTypeId
            carTypeName
          }
          images {
            thumb
            full
          }
          startingPrice
          numSuppliers
          overlayPromotion {
           adminPromotionLine1
           adminPromotionLine2
          }
         capsulePromotion {
            code
            name
        }
        }
        availableFilter {
          maxPrice
          minPrice
          carBrand {
            carBrandId
            name
          }
          carType {
            carTypeId
            name
          }
          carSupplier {
            carSupplierId
            name
          }
          capsulePromotion {
            code
            name
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
