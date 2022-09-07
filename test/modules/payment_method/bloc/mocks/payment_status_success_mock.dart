import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart'
    as payment_initaite_v2;
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/usecases/payment_status_usecases.dart';

///For Success
class PaymentStatusUseCasesImplSuccessMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>?> getNewBookingUrn(
      String bookingUrn) async {
    return Right(
      PaymentNewBookingUrnModelDomain(
        generateNewBookingUrn: GenerateNewBookingUrn(
          data: Data(
            newBookingUrn: "111",
          ),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, payment_initaite_v2.PaymentInitiateNewModelDomain?>?>
      getPaymentInitiateV2(PaymentInitiateArgumentModelDomain argument) async {
    return Right(payment_initaite_v2.PaymentInitiateNewModelDomain(
      initiatePaymentV2: payment_initaite_v2.InitiatePaymentV2(
        data: payment_initaite_v2.Data(
          bookingUrn: '111',
        ),
      ),
    ));
  }

  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Right(
      PaymentStatusModelDomain(
        paymentStatus: PaymentStatus(
          data: PaymentStatusData(
            paymentMethod: 'paymentMethod',
            paymentPhase: 'paymentPhase',
            paymentStatus: 'SUCCESS',
            phaseState: 'phaseState',
            deeplinkUrl: 'deeplinkUrl',
            callbackUrl: 'callbackUrl',
            errorDescription: 'errorDescription',
          ),
        ),
      ),
    );
  }
}

///For Success with NULL
class PaymentStatusUseCasesImplNullMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>?> getNewBookingUrn(
      String bookingUrn) async {
    return Right(
      PaymentNewBookingUrnModelDomain(
        generateNewBookingUrn: GenerateNewBookingUrn(
          data: Data(
            newBookingUrn: null,
          ),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Right(PaymentStatusModelDomain(
        paymentStatus: PaymentStatus(data: null, status: null)));
  }

  @override
  Future<Either<Failure, payment_initaite_v2.PaymentInitiateNewModelDomain?>?>
      getPaymentInitiateV2(PaymentInitiateArgumentModelDomain argument) async {
    return Right(payment_initaite_v2.PaymentInitiateNewModelDomain(
      initiatePaymentV2: payment_initaite_v2.InitiatePaymentV2(
        data: payment_initaite_v2.Data(
          bookingUrn: null,
        ),
      ),
    ));
  }
}

class PaymentStatusWiseDeeplinkUrlMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Right(
      PaymentStatusModelDomain(
        paymentStatus: PaymentStatus(
          data: PaymentStatusData(
            paymentMethod: 'paymentMethod',
            paymentPhase: 'paymentPhase',
            paymentStatus: 'paymentStatus',
            phaseState: 'phaseState',
            deeplinkUrl: 'deeplinkUrl',
            callbackUrl: 'callbackUrl',
            errorDescription: 'errorDescription',
          ),
        ),
      ),
    );
  }
}

class PaymentStatusWiseStatusFailedMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Right(
      PaymentStatusModelDomain(
        paymentStatus: PaymentStatus(
          data: PaymentStatusData(
            paymentMethod: 'paymentMethod',
            paymentPhase: 'paymentPhase',
            paymentStatus: 'FAILED',
            phaseState: 'phaseState',
            deeplinkUrl: null,
            callbackUrl: 'callbackUrl',
            errorDescription: 'errorDescription',
          ),
        ),
      ),
    );
  }
}

class PaymentStatusWiseElseMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Right(
      PaymentStatusModelDomain(
        paymentStatus: PaymentStatus(
          data: PaymentStatusData(
            paymentMethod: 'paymentMethod',
            paymentPhase: 'paymentPhase',
            paymentStatus: 'paymentStatus',
            phaseState: 'phaseState',
            deeplinkUrl: null,
            callbackUrl: 'callbackUrl',
            errorDescription: 'errorDescription',
          ),
        ),
      ),
    );
  }
}

class PaymentStatusWisePaymentStatusNULLMock extends PaymentStatusUseCasesImpl {
  @override
  Future<Either<Failure, PaymentStatusModelDomain?>?> getPaymentStatus(
      String bookingUrn) async {
    return Right(
      PaymentStatusModelDomain(
        paymentStatus: PaymentStatus(
          data: null,
        ),
      ),
    );
  }
}
