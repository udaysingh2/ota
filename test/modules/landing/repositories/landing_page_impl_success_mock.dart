import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/domain/landing/models/landing_models.dart';
import 'package:ota/domain/landing/repositories/landing_page_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class LandingPageRepositoryImplSuccessMock
    implements LandingPageRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  LandingPageRemoteDataSource? roomDetailRemoteDataSource;

  @override
  Future<Either<Failure, LandingData?>> getLandingPage() async {
    String json = fixture("landing/landing_data.json");
    LandingData landingData = LandingData.fromJson(json);
    return Right(landingData);
  }
}
