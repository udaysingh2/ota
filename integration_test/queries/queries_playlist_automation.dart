import '../models/argument_playlist_data_model_automation.dart';

class QueriesPlayListAutomation {
  static String getPlayListData(PlayListDataArgumentAutomation argument) {
    return '''
          mutation {
              getPlaylists(
                playlistInput: ${argument.toGraphqlPlaylistInput()}
              ) {
                staticPlaylist {
                  name
                  source
                  serviceName
                  list {
                    hotelId
                    hotelName
                    rating
                    image
                    review {
                      score
                      numReview
                      description
                    }
                    address {
                      locationId
                      locationName
                      address1
                      cityId
                      cityName
                      countryId
                      countryName
                    }
                    promotion{
                      promotionText
                    }
                  }
                }
                dynamicPlaylist {
                  name
                  source
                  serviceName
                  list {
                    hotelId
                    hotelName
                    rating
                    image
                    review {
                      score
                      numReview
                      description
                    }
                    address {
                      locationId
                      locationName
                      address1
                      cityId
                      cityName
                      countryId
                      countryName
                    }
                    promotion{
                      promotionText
                    }
                  }
                }
              }
            }
    ''';
  }
}
