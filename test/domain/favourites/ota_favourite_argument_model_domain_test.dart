import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Customer model test group", () {
    test('Customer model test', () async {
      TourDetailDomain tourDetailDomain = TourDetailDomain(
        cityId: '10',
        name: 'Tour',
        countryId: '10',
        serviceId: '12',
        image: "http://singh.com",
        location: 'noida',
        category: 'tour'
      );
      tourDetailDomain.toMap();
      
      TicketDetailDomain ticketDetailDomain = TicketDetailDomain(
        cityId: '10',
        name: 'Tour',
        countryId: '10',
        serviceId: '12',
        image: "http://singh.com",
        location: 'noida',
        category: 'tour'
      );
      ticketDetailDomain.toMap();

      OtaFavoritesArgumentDomainModel otaFavoritesArgumentDomainModel =
          OtaFavoritesArgumentDomainModel(serviceName: 'Hotel',tourDetail: tourDetailDomain,ticketDetail: ticketDetailDomain);
      otaFavoritesArgumentDomainModel.toMap();
    });
  });
}
