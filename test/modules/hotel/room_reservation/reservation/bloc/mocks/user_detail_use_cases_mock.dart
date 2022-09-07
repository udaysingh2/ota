import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/usecases/customer_use_cases.dart';

class UserDetailUseCasesSuccessMock extends CustomerUseCasesImpl {
  @override
  Future<Either<Failure, CustomerData>?> getCustomerData() async {
    return Right(
      CustomerData(
        data: Data(
          firstName: 'firstName',
          lastName: 'lastName',
          email: 'email',
          phoneNumber: 'phoneNumber',
        ),
      ),
    );
  }
}

class UserDetailUseCasesFailureMock extends CustomerUseCasesImpl {
  @override
  Future<Either<Failure, CustomerData>?> getCustomerData() async {
    return Left(
      InternetFailure(),
    );
  }
}
