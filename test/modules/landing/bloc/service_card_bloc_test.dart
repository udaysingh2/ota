import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/landing/service_card/usecases/service_card_usecases.dart';
import 'package:ota/modules/landing/bloc/service_card_bloc.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';

import 'mocks/service_card_use_cases_mock.dart';

void main() {
  ServiceCardBloc bloc = ServiceCardBloc();
  ServiceCardUseCasesImpl successMock = ServiceCardUseCasesAllSuccessMock();
  ServiceCardUseCasesImpl dataNULLMock = ServiceCardUseCasesDataNullMock();
  ServiceCardUseCasesImpl failureMock = ServiceCardUseCasesFailureMock();

  test('For ServiceCardBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.preferenceScreenState, PreferenceScreenState.dontshow);
  });

  test('For ServiceCardBloc class ==> updateSearchString()', () {
    bloc.updateSearchString('');

    expect(bloc.state.pageState, LandingViewPageState.initial);
  });

  group('For ServiceCardBloc class ==> getServiceCardData()', () {
    test('If Failure then', () async {
      bloc.serviceCardUseCasesImpl = failureMock;
      await bloc.getServiceCardData(false);

      Either<Failure, ServiceCardModelDomainData?>? result =
          await failureMock.getServiceCard();

      expect(result?.isLeft, true);
      expect(bloc.state.pageState, LandingViewPageState.internetFailure);
    });

    test('if argument has all valid data but popup is NULL then', () async {
      bloc.serviceCardUseCasesImpl = dataNULLMock;
      await bloc.getServiceCardData(false);

      Either<Failure, ServiceCardModelDomainData?>? result =
          await dataNULLMock.getServiceCard();

      expect(result?.isRight, true);
      expect(bloc.state.preferenceScreenState, PreferenceScreenState.dontshow);

      expect(bloc.state.pageState, LandingViewPageState.failure);
    });

    test('if argument has all valid data then', () async {
      bloc.serviceCardUseCasesImpl = successMock;
      await bloc.getServiceCardData(false);

      Either<Failure, ServiceCardModelDomainData?>? result =
          await successMock.getServiceCard();

      expect(result?.isRight, true);
      expect(bloc.state.pageState, LandingViewPageState.success);
    });
  });
}
