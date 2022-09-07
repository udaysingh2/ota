import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_data_source_mock.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/repositories/hotel_landing_static_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/usecases/hotel_landing_static_room_usecases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  HotelLandingStaticUseCase? hotelLandingStaticUseCase;
  TestWidgetsFlutterBinding.ensureInitialized();
  HotelLandingStaticSingleDataArgument argument =
      HotelLandingStaticSingleDataArgument(
          playlistId: "playlistId", userId: "userId");
  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelLandingStaticUseCase = HotelLandingStaticUseCasesImpl();

    /// Code coverage for mock class
    HotelLandingStaticRepository hotelLandingStaticRepository =
        HotelLandingStaticRepositoryImpl(
            remoteDataSource: HotelLandingStaticMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());
    hotelLandingStaticUseCase = HotelLandingStaticUseCasesImpl(
        repository: hotelLandingStaticRepository);
  });

  test('Hotel Landing Static Use Case test', () async {
    /// Consent user cases impl
    final hotelStaticUseCaseResult =
        await hotelLandingStaticUseCase!.getPlaylist(argument);

    /// Get model from mock data.
    final HotelLandingStaticSingleData? model = hotelStaticUseCaseResult!.right;

    expect(model?.getPlaylists != null, false);
  });
}
