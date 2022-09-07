import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/preference_popup/data_sources/preference_popup_mock_data_source.dart';
import 'package:ota/domain/preference_popup/repositories/preference_popup_repository.dart';
import 'package:ota/domain/preference_popup/usecases/preference_popup_usecase.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  PreferencePopUpUseCases? preferencePopUpUseCases;

  setUpAll(() async {
    PreferencePopUpRepository preferencePopUpRepository =
        PreferencePopUpRepositoryImpl(
            remoteDataSource: PreferencePopUpMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());
    preferencePopUpUseCases =
        PreferencePopUpUseCasesImpl(repository: preferencePopUpRepository);
  });

  test('Preference Pop up usecases', () async {
    final preferencePopupResult =
        await preferencePopUpUseCases!.getPopUpState("id", "type", "endDate");
    expect(preferencePopupResult?.isLeft, false);
  });
}
