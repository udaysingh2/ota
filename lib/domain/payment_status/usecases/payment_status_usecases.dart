import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/repositories/payment_status_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class PaymentStatusUseCases {
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn);
  Future<Either<Failure, PaymentInitiateNewModelDomain?>?> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument);
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>?> getNewBookingUrn(
      String bookingUrn);
  Future<Either<Failure, PaymentNewCarBookingUrnModelDomain?>?>
      getNewCarBookingUrn(String bookingUrn);
}

class PaymentStatusUseCasesImpl implements PaymentStatusUseCases {
  PaymentStatusRepository? paymentStatusRepository;

  /// Dependence injection via constructor
  PaymentStatusUseCasesImpl({PaymentStatusRepository? repository}) {
    if (repository == null) {
      paymentStatusRepository = PaymentStatusRepositoryImpl();
    } else {
      paymentStatusRepository = repository;
    }
  }

  @override
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>?> getNewBookingUrn(
      String bookingUrn) async {
    return await paymentStatusRepository?.getNewBookingUrn(bookingUrn);
  }

  @override
  Future<Either<Failure, PaymentNewCarBookingUrnModelDomain?>?>
      getNewCarBookingUrn(String bookingUrn) async {
    return await paymentStatusRepository?.getNewCarBookingUrn(bookingUrn);
  }

  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return await paymentStatusRepository?.getPaymentStatus(bookingUrn);
  }

  @override
  Future<Either<Failure, PaymentInitiateNewModelDomain?>?> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) async {
    return await paymentStatusRepository?.getPaymentInitiateV2(argument);
  }
}
