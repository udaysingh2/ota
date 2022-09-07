import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/usecases/payment_status_usecases.dart';
import 'package:ota/modules/payment_method/bloc/payment_status_bloc.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:ota/modules/payment_method/view_model/payment_status_view_model.dart';

import 'mocks/payment_status_failure_mock.dart';
import 'mocks/payment_status_success_mock.dart';

void main() {
  PaymentMethodStatusViewBloc bloc = PaymentMethodStatusViewBloc();
  PaymentStatusUseCasesImpl successMock =
      PaymentStatusUseCasesImplSuccessMock();
  PaymentStatusUseCasesImpl failureMock =
      PaymentStatusUseCasesImplFailureMock();
  PaymentStatusUseCasesImpl nullMock = PaymentStatusUseCasesImplNullMock();
  PaymentStatusUseCasesImpl deepURLMock = PaymentStatusWiseDeeplinkUrlMock();
  PaymentStatusUseCasesImpl statusFailedMock =
      PaymentStatusWiseStatusFailedMock();
  PaymentStatusUseCasesImpl elseMock = PaymentStatusWiseElseMock();
  PaymentStatusUseCasesImpl paymentNullMock =
      PaymentStatusWisePaymentStatusNULLMock();
  PaymentStatusUseCasesImpl elseFailMock =
      PaymentStatusUseCasesImplElseFailureMock();

  test('For PaymentStatusBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.pageState, PaymentStatusViewPageState.initial);
  });

  test('For PaymentStatusBloc class ==> initDefaultValue()', () {
    bloc.setDeepLinkAsFound();

    expect(bloc.isDeepLinkFound, true);
  });

  group('For PaymentStatusBloc class ==> getNewBookingUrn', () {
    test('If argument is NUll then', () async {
      await bloc.getNewBookingUrn(null);

      expect(bloc.state.pageState, PaymentStatusViewPageState.failure);
    });

    test('If bookingUrn is NULL in response then', () async {
      bloc.paymentStatusUseCasesImpl = nullMock;
      await bloc.getNewBookingUrn(argument);

      Either<Failure, PaymentNewBookingUrnModelDomain?>? result =
          await nullMock.getNewBookingUrn('');

      expect(result?.isRight, true);
      expect(bloc.state.pageState, PaymentStatusViewPageState.failure);
    });

    test('If argument has valid argument then', () async {
      bloc.paymentStatusUseCasesImpl = successMock;
      await bloc.getNewBookingUrn(argument);

      Either<Failure, PaymentNewBookingUrnModelDomain?>? result =
          await successMock.getNewBookingUrn('');

      expect(result?.isRight, true);
    });

    test('If Internet failure then', () async {
      bloc.paymentStatusUseCasesImpl = failureMock;
      await bloc.getNewBookingUrn(argument);

      Either<Failure, PaymentNewBookingUrnModelDomain?>? result =
          await failureMock.getNewBookingUrn('');

      expect(result?.isLeft, true);
    });
  });

  group('For PaymentStatusBloc class ==> getInitialPayment', () {
    test('If argument is NUll then', () async {
      await bloc.getInitialPaymentV2(
          null, Helpers().parseDateTime('2022-03-16'));

      expect(bloc.state.pageState, PaymentStatusViewPageState.failure);
    });

    test('If bookingUrn is NULL in response then', () async {
      bloc.paymentStatusUseCasesImpl = nullMock;
      await bloc.getInitialPaymentV2(
          argument, Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentInitiateNewModelDomain?>? result =
          await nullMock.getPaymentInitiateV2(
              argument.toPaymentInitiateArgumentModelDomain());

      expect(result?.isRight, true);
      expect(bloc.state.pageState, PaymentStatusViewPageState.failure);
    });

    test('If argument has valid argument then', () async {
      bloc.paymentStatusUseCasesImpl = successMock;
      await bloc.getInitialPaymentV2(
          argument, Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentInitiateNewModelDomain?>? result =
          await successMock.getPaymentInitiateV2(
              argument.toPaymentInitiateArgumentModelDomain());

      expect(result?.isRight, true);
    });

    test('If Internet failure then', () async {
      bloc.paymentStatusUseCasesImpl = failureMock;
      await bloc.getInitialPaymentV2(
          argument, Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentInitiateNewModelDomain?>? result =
          await failureMock.getPaymentInitiateV2(
              argument.toPaymentInitiateArgumentModelDomain());

      expect(result?.isLeft, true);
    });
  });

  group('For PaymentStatusBloc class ==> getPaymentStatus', () {
    test('If argument is NUll then', () async {
      await bloc.getPaymentStatus(null, Helpers().parseDateTime('2022-03-16'));

      expect(bloc.state.pageState, PaymentStatusViewPageState.failure);
    });

    test('If argument has valid argument then', () async {
      bloc.paymentStatusUseCasesImpl = successMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await successMock.getPaymentStatus('111');

      expect(result?.isRight, true);
    });

    test('If DeepURL check then', () async {
      bloc.isDeepLinkFound = false;
      bloc.paymentStatusUseCasesImpl = deepURLMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await deepURLMock.getPaymentStatus('111');

      expect(result?.isRight, true);
    });

    test('If Status Failed check then', () async {
      bloc.paymentStatusUseCasesImpl = statusFailedMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await statusFailedMock.getPaymentStatus('111');

      expect(result?.isRight, true);
    });

    test('If Else Status check then', () async {
      bloc.paymentStatusUseCasesImpl = elseMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await elseMock.getPaymentStatus('111');

      expect(result?.isRight, true);
    });

    test('If Payment Status is NULL then', () async {
      bloc.paymentStatusUseCasesImpl = paymentNullMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await paymentNullMock.getPaymentStatus('111');

      expect(result?.isRight, true);
    });

    test('If Internet failure then', () async {
      bloc.paymentStatusUseCasesImpl = failureMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2022-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await failureMock.getPaymentStatus('');

      expect(result?.isLeft, true);
    });

    test('If Internet else failure then', () async {
      bloc.state.retriesAfterExpiery = 0;
      bloc.paymentStatusUseCasesImpl = elseFailMock;
      await bloc.getPaymentStatus('111', Helpers().parseDateTime('2020-03-16'));

      Either<Failure, PaymentStatusModelDomain?>? result =
          await elseFailMock.getPaymentStatus('');

      expect(result?.isLeft, true);
    });
  });
}

PaymentMethodInitiateArgument argument = PaymentMethodInitiateArgument(
    paymentDetails: [PaymentMethodTypeArgument(paymentMethod: "", price: 0.0)],
    bookingUrn: 'Bangkok',
    currency: '',
    newbookingUrn: '',
    otaCountDownController: OtaCountDownController(durationInSecond: 10));
