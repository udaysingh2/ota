import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_mock_data_source.dart';
import 'package:ota/channels/register_confirm_landing_handler/repositories/register_confirm_landing_repository_impl.dart';

void main() {
  RegisterConfirmLandingRepository? registerConfirmLandingRepository;

  setUpAll(() async {
    registerConfirmLandingRepository = RegisterConfirmLandingRepositoryImpl();

    registerConfirmLandingRepository = RegisterConfirmLandingRepositoryImpl(
      remoteDataSource: RegisterConfirmLandingMockDataSourceImpl(),
    );
  });

  test('Register Confirm Landing Repository test', () async {
    // ignore: await_only_futures
    final res = await registerConfirmLandingRepository!.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "registerConfirmLanding");
    registerConfirmLandingRepository!.dispose();
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
  });
}
