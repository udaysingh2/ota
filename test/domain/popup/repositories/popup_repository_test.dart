import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/popup/data_sources/popup_remote_data_source.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source_mock.dart';
import 'package:ota/domain/popup/models/popup_models.dart';
import 'package:ota/domain/popup/repositories/popup_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class PopUpRemoteDataSourceFailureMock implements PopupRemoteDataSource {
  @override
  Future<PopupModelDomain> getPopup() {
    throw exp.ServerException(null);
  }
}

void main() {
  PopupRepository? popupRepositoryMock;
  PopupRepository? popupRepositoryInternetFailure;
  PopupRepository? popupRepositoryServerException;
  setUpAll(() async {
    /// Code coverage for default implementation.
    popupRepositoryMock = PopupRepositoryImpl();

    /// Code coverage for mock class
    popupRepositoryMock = PopupRepositoryImpl(
        remoteDataSource: PopupMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    popupRepositoryInternetFailure = PopupRepositoryImpl(
        remoteDataSource: PopUpRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());

    /// Coverage in-case of SERVER failure
    popupRepositoryServerException = PopupRepositoryImpl(
        remoteDataSource: PopUpRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'popup Repository Mock Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await popupRepositoryMock!.getPopup();

    /// Get model from mock data.
    final PopupModelDomain? popUp = result.right;

    /// Condition check for booking data value null
    expect(popUp?.getPopups != null, true);
  });

  test(
      'popup Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await popupRepositoryInternetFailure!.getPopup();

    expect(result.isLeft, true);
  });

  test(
      'popup Repository ServerE xception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await popupRepositoryServerException!.getPopup();

    expect(result.isLeft, true);
  });
}
