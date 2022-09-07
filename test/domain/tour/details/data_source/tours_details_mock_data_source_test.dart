import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/details/data_sources/tours_details_remote_data_source.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import '../../../../mocks/tour/tours_details_remote_data_source_mock.dart';

void main() {
  TourDetailArgumentDomain tourDetailArgument = TourDetailArgumentDomain(
    countryId: "MA05110001",
    cityId: 'MA05110041',
    tourId: 'MA05110042',
    tourDate: '2021-12-26',
  );
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Tour Detail Mock Data Source Group ", () {
    test("Tour Detail Data Source", () async {
      TourDetailsRemoteDataSource tourDetailMockDataSource =
          TourDetailsMockDataSourceImpl();
      tourDetailMockDataSource.getTourDetails(tourDetailArgument);
    });
    test("Tour Detail", () async {
      TourDetailsRemoteDataSource tourDetailMockData =
          TourDetailsMockDataSourceImpl();
      final result =
          await tourDetailMockData.getTourDetails(tourDetailArgument);
      expect(result.getTourDetails!.data != null, true);
    });
  });
}
