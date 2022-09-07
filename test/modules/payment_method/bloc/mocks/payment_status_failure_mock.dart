import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/usecases/payment_status_usecases.dart';

class PaymentStatusUseCasesImplFailureMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>?> getNewBookingUrn(
      String bookingUrn) async {
    return Left(InternetFailure());
  }

  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Left(InternetFailure());
  }

  @override
  Future<Either<Failure, PaymentInitiateNewModelDomain?>?> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) async {
    return Left(InternetFailure());
  }
}

class PaymentStatusUseCasesImplElseFailureMock
    extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Left(InternetFailure());
  }
}
