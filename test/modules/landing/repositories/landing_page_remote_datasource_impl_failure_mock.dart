import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/domain/landing/models/landing_models.dart';

class LandingPageRemoteDataSourceFailureMock
    implements LandingPageRemoteDataSource {
  @override
  Future<LandingData> getLandingPage() {
    throw exp.ServerException(null);
  }
}
