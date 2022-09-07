import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';

class QueriesTourTicketPlaylist {
  static String getTourTicketPlaylistData(
      TourTicketPlaylistArgumentDomain argument) {
    return '''
      mutation {
        getTourAndTicketPlaylist(
          playlistRequest: {
            lat:  ${argument.lat}
            long:  ${argument.long}
            offset:  ${argument.offset}
            limit:  ${argument.limit}
            playlistName: "${argument.playlistName}"
          }
        ) {
          data {
          playlistId
          playlistName
            listOfPlaylist {
              id
              cityId
              countryId
              imageUrl
              name
              locationName
              cityName
              styleName
              startPrice
              promotionText_line1
              promotionText_line2
              capsulePromotion {
		            name
				        code
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
