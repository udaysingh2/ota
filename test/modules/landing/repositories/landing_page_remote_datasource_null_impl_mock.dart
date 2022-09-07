import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/domain/landing/models/landing_models.dart';

import '../../../mocks/fixture_reader.dart';

class RoomDetailRemoteDataSourceImplNullDataMock
    implements LandingPageRemoteDataSource {
  @override
  Future<LandingData> getLandingPage() async {
    String json = fixture("landing/landing_data.json");
    LandingData landingData = LandingData.fromJson(json);
    return landingData;
  }
}
