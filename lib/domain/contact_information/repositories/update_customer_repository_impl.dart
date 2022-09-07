import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/contact_information/data_sources/update_customer_remote_data_source.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

/// Interface for HotelServiceRepository repository.
abstract class UpdateCustomerRepository {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, UpdateCustomerData>> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData);
}

/// HotelServiceRepositoryImpl will contain the HotelServiceRepository implementation.
class UpdateCustomerRepositoryImpl implements UpdateCustomerRepository {
  UpdateCustomerRemoteDataSource? updateCustomerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  UpdateCustomerRepositoryImpl(
      {UpdateCustomerRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      updateCustomerRemoteDataSource =
          UpdateCustomerRemoteDataSourceImpl(); //HotelServiceRemoteDataSourceImpl();
    } else {
      updateCustomerRemoteDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, UpdateCustomerData>> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final addonServiceResult = await updateCustomerRemoteDataSource
            ?.updateCustomerData(contactInformationArgumentData);
        return Right(addonServiceResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
