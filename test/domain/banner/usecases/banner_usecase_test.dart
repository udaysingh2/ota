import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';

import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';
import 'package:ota/domain/landing/banner/usecases/banner_usecases.dart';

import '../../../mocks/fixture_reader.dart';

class BannerUsecase implements LandingBannerRepositoryImpl {
  @override
  LandingBannerRemoteDataSource? bannerRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, LandingBannerModelDomain?>> getLandingBanner(
      String bannerType) async {
    Map<String, dynamic> map = json.decode(fixture("banner/banner.json"));
    LandingBannerModelDomain sort = LandingBannerModelDomain.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("banner Use case group", () {
    test('banner Use case', () async {
      LandingBannerUseCasesImpl();
      LandingBannerUseCases landingBannerUseCases =
          LandingBannerUseCasesImpl(repository: BannerUsecase());
      landingBannerUseCases.getLandingBanner("bannerType");
    });
  });
}
