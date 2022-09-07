import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/domain/payment_method/usecases/payment_method_use_cases.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/payment_method_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

import 'mocks/payment_method_failure_mock.dart';
import 'mocks/payment_method_success_mock.dart';

void main() {
  PaymentMethodBloc bloc = PaymentMethodBloc();
  PaymentMethodUseCases successMock = PaymentMethodUseCasesSuccessMock();
  PaymentMethodUseCases failureMock = PaymentMethodUseCasesFailureMock();
  String? userId;

  test('For Payment method Bloc class ==> initDefaultValue()', () {
    bloc.initDefaultValue();

    expect(bloc.initDefaultValue().paymentMethodList.isEmpty, true);
    expect(bloc.initDefaultValue().paymentMethodList.length, 0);
  });

  // test('For For Payment method Bloc class ==> getPaymentMethodListData() null',
  //     () async {
  //   bloc.getPaymentMethodListData(null);
  //   expect(_userId == null, true);
  // });
  test(
      'For RecommendedLocationBloc class ==> getPaymentMethodListData() not null',
      () async {
    userId = "1";
    bloc.getPaymentMethodListData(userId);
    expect(bloc.state.paymentMethodViewState, PaymentMethodViewState.loading);
  });

  test(
      'For RecommendedLocationBloc class ==> getPaymentMethodListData() loaded',
      () async {
    userId = "1";
    bloc.getPaymentMethodListData(userId);

    Either<Failure, PaymentMethodModelDomain>? result =
        (await successMock.getPaymentMethodListData(userId: userId!));
    expect(result?.isRight, true);
    expect(bloc.state.paymentMethodViewState, PaymentMethodViewState.loading);
  });

  test(
      'For RecommendedLocationBloc class ==> getPaymentMethodListData() failure',
      () async {
    userId = "1";
    bloc.getPaymentMethodListData(userId);

    Either<Failure, PaymentMethodModelDomain>? result =
        (await failureMock.getPaymentMethodListData(userId: userId!));
    expect(result?.isLeft, true);
    expect(bloc.state.paymentMethodViewState, PaymentMethodViewState.loading);
  });

  test(
      'For RecommendedLocationBloc class ==> getPaymentMethodListData() failure',
      () {
    bloc.getAllPaymentMethodList();
    bloc.getDefaultPaymentMethod();
  });
}

PaymentMethodViewModel argument = PaymentMethodViewModel(
  paymentMethodId: '',
  isDefault: false,
  cardRef: '',
  paymentMethodType: PaymentMethodType.jcb,
  cardMask: '',
  nickname: '',
);
