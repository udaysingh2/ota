import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/ota_contact_information/data_sources/ota_update_customer_remote_data_source.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';
import 'package:ota/domain/tours/ota_contact_information/repositories/ota_update_customer_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';


class OtaUpdateCustomerRepositoryImplSuccessMock implements OtaUpdateCustomerRepositoryImpl {
  @override
  OtaUpdateCustomerRemoteDataSource? updateCustomerRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, OtaUpdateCustomerDetailsData>> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain argument) async {
    String json = fixture("tour/ota_contact_information_success_mock.json");
    ///Convert into Model
    OtaUpdateCustomerDetailsData model = OtaUpdateCustomerDetailsData.fromJson(json);
    return Right(model);
  }

}
