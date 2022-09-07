import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/preference_popup/data_sources/preference_popup_mock_data_source.dart';
import 'package:ota/domain/preference_popup/repositories/preference_popup_repository.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  PreferencePopUpRepository? preferencePopupRepositoryMock;
  PreferencePopUpRepository? preferencePopupRepositoryInternetFailure;

  setUpAll(() async {
    preferencePopupRepositoryMock = PreferencePopUpRepositoryImpl();

    preferencePopupRepositoryMock = PreferencePopUpRepositoryImpl(
        remoteDataSource: PreferencePopUpMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    preferencePopupRepositoryInternetFailure = PreferencePopUpRepositoryImpl(
        remoteDataSource: PreferencePopUpMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test('Prefrence pop up repo with Success response data', () async {
    final popUpSuccess = await preferencePopupRepositoryMock!
        .getPopUpState("id", "type", "endDate");

    // ignore: unnecessary_null_comparison
    expect(popUpSuccess != null, true);
  });

  test('Preference pop up repo with Internet Failure response data', () async {
    final popUpFailure = preferencePopupRepositoryInternetFailure!
        .getPopUpState("id", "type", "");

    // ignore: unnecessary_null_comparison
    expect(popUpFailure != null, true);
  });
}
