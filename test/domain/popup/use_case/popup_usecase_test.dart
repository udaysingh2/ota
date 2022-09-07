import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source.dart';
import 'package:ota/domain/popup/models/popup_models.dart';
import 'package:ota/domain/popup/repositories/popup_repository_impl.dart';
import 'package:ota/domain/popup/usecases/popup_usecases.dart';

import '../../../mocks/fixture_reader.dart';

class PopUpUsecase implements PopupRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  PopupRemoteDataSource? popupRemoteDataSource;

  @override
  Future<Either<Failure, PopupModelDomain?>> getPopup() async {
    Map<String, dynamic> map = json.decode(fixture("popup/popup.json"));
    PopupModelDomain sort = PopupModelDomain.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("pop up  Use case group", () {
    test('pop up Use case', () async {
      PopupUseCasesImpl();
      PopupUseCases popupUseCases =
          PopupUseCasesImpl(repository: PopUpUsecase());
      popupUseCases.getPopup();
    });
  });
}
