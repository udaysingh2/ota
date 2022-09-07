import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/ota_contact_information/data_sources/ota_update_customer_remote_data_source.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';

/// Interface for HotelServiceRepository repository.
abstract class OtaUpdateCustomerRepository {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, OtaUpdateCustomerDetailsData>> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain contactInformationArgumentData);
}

/// HotelServiceRepositoryImpl will contain the HotelServiceRepository implementation.
class OtaUpdateCustomerRepositoryImpl implements OtaUpdateCustomerRepository {
  OtaUpdateCustomerRemoteDataSource? updateCustomerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  OtaUpdateCustomerRepositoryImpl(
      {OtaUpdateCustomerRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      updateCustomerRemoteDataSource =
          OtaUpdateCustomerRemoteDataSourceImpl(); //HotelServiceRemoteDataSourceImpl();
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
  Future<Either<Failure, OtaUpdateCustomerDetailsData>> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain contactInformationArgumentData) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final addonServiceResult = await updateCustomerRemoteDataSource
            ?.updateCustomerDetails(contactInformationArgumentData);
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
