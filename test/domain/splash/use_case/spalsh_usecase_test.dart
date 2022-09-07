import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';
import 'package:ota/domain/splash/models/splash_model.dart';
import 'package:ota/domain/splash/repositories/splash_repository_impl.dart';
import 'package:ota/domain/splash/usecases/splash_use_cases.dart';

import '../../../mocks/fixture_reader.dart';

class SplashUseCaseMock implements SplashRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  SplashRemoteDataSource? splashRemoteDataSource;

  @override
  Future<Either<Failure, SplashModel>> getSplashData() async {
    Map<String, dynamic> map = json.decode(fixture("splash/splash_model.json"));
    SplashModel sort = SplashModel.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("pop up  Use case group", () {
    test('pop up Use case', () async {
      SplashUseCasesImpl();
      SplashUseCases splashUseCases =
          SplashUseCasesImpl(repository: SplashUseCaseMock());
      splashUseCases.getSplashData();
    });
  });
}
