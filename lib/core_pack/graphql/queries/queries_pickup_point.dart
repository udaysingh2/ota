class QueriesPickUpPoint {
  static String getPickUpPointDetail(String zoneId) {
    return '''
        query {
        getPickUpDetails(pickUpDetailsRequest: { 
             zoneId: "$zoneId"
         }
         ) 
        {
          data {
          pickupPoints{
            id
            name
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
