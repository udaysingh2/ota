import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';
import 'package:ota/domain/contact_information/use_cases/update_customer_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

class ContactInformationAllSuccessMock extends UpdateCustomerUseCases {
  @override
  Future<Either<Failure, UpdateCustomerData>?> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    return Right(UpdateCustomerData(
      updateCustomerDetails: UpdateCustomerDetails(
        status: Status(
          code: '1000',
        ),
      ),
    ));
  }
}

class ContactInformationStatusNot1000Mock extends UpdateCustomerUseCases {
  @override
  Future<Either<Failure, UpdateCustomerData>?> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    return Right(UpdateCustomerData(
      updateCustomerDetails: UpdateCustomerDetails(
        status: Status(
          code: '200',
        ),
      ),
    ));
  }
}

class ContactInformationFailureMock extends UpdateCustomerUseCases {
  @override
  Future<Either<Failure, UpdateCustomerData>?> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    return Left(InternetFailure());
  }
}
