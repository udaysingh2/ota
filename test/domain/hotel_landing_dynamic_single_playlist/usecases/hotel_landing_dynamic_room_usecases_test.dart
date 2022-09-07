import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_data_source_mock.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/repositories/hotel_landing_dynamic_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/usecases/hotel_landing_dynamic_room_usecases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  HotelLandingDynamicUseCase? hotelLandingDynamicUseCase;
  TestWidgetsFlutterBinding.ensureInitialized();
  HotelLandingDynamicSingleDataArgument argument =
      HotelLandingDynamicSingleDataArgument(
          playlistId: "playlistId", userId: "userId");
  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelLandingDynamicUseCase = HotelLandingDynamicUseCasesImpl();

    /// Code coverage for mock class
    HotelLandingDynamicRepository hotelLandingDynamicRepository =
        HotelLandingDynamicRepositoryImpl(
            remoteDataSource: HotelLandingDynamicMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());
    hotelLandingDynamicUseCase = HotelLandingDynamicUseCasesImpl(
        repository: hotelLandingDynamicRepository);
  });

  test('Hotel Landing Dynamic Use Case test', () async {
    /// Consent user cases impl
    final hotelDynamicUseCaseResult =
        await hotelLandingDynamicUseCase!.getPlaylist(argument);

    /// Get model from mock data.
    final HotelLandingDynamicSingleData? model =
        hotelDynamicUseCaseResult!.right;

    expect(model?.getPlaylists != null, false);
  });
}
