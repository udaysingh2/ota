import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source.dart';
import 'package:ota/domain/popup/models/popup_models.dart';

/// Interface for HotelDetailRepository repository.
abstract class PopupRepository {
  Future<Either<Failure, PopupModelDomain?>> getPopup();
}

class PopupRepositoryImpl implements PopupRepository {
  PopupRemoteDataSource? popupRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PopupRepositoryImpl(
      {PopupRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      popupRemoteDataSource = PopupRemoteDataSourceImpl();
      // popupRemoteDataSource = PopupMockDataSourceImpl();

    } else {
      popupRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, PopupModelDomain?>> getPopup() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final roomResult = await popupRemoteDataSource?.getPopup();
        return Right(roomResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
