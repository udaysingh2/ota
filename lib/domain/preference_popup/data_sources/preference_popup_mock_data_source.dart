import 'package:ota/domain/preference_popup/data_sources/preference_popup_remote_data_source.dart';

class PreferencePopUpMockDataSourceImpl
    implements PreferencePopUpRemoteDataSource {
  PreferencePopUpMockDataSourceImpl();
  @override
  Future<bool> getPopUpState(String id, String type, String endDate) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return true;
  }
}
