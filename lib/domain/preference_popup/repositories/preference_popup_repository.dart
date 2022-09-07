import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/preference_popup/data_sources/preference_popup_remote_data_source.dart';

/// Interface for HotelDetailRepository repository.
abstract class PreferencePopUpRepository {
  Future<Either<Failure, bool?>> getPopUpState(
      String id, String type, String endDate);
}

class PreferencePopUpRepositoryImpl implements PreferencePopUpRepository {
  PreferencePopUpRemoteDataSource? preferencePopUpRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  PreferencePopUpRepositoryImpl(
      {PreferencePopUpRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      preferencePopUpRemoteDataSource =
          //PreferencePopUpMockDataSourceImpl();
          PreferencePopUpRemoteDataSourceImpl();
    } else {
      preferencePopUpRemoteDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, bool?>> getPopUpState(
      String id, String type, String endDate) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await preferencePopUpRemoteDataSource?.getPopUpState(
            id, type, endDate);
        return Right(result);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
