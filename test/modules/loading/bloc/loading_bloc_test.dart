import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/usecases/loading_usecases.dart';
import 'package:ota/modules/loading/bloc/loading_bloc.dart';
import 'package:ota/modules/loading/view_model/loading_view_model.dart';

import 'mocks/loading_bloc_failure_mock.dart';
import 'mocks/loading_bloc_null_mock.dart';
import 'mocks/loading_bloc_success_mock.dart';

const _serviceName = "HOTEL";

void main() {
  LoadingBloc bloc = LoadingBloc();
  LoadingUseCases successMock = LoadingUseCasesSuccessMock();
  LoadingUseCases failureMock = LoadingUseCasesFailureMock();
  LoadingUseCases nullMock = LoadingUseCasesNullMock();

  test('For LoadingBloc class ==> initDefaultValue() ', () async {
    bloc.initDefaultValue();
  });

  test('For LoadingBloc class ==> getLoadingData() ', () async {
    bloc.loadingUseCasesImpl = successMock;
    bloc.getLoadingData(_serviceName);
    await bloc.mapLoadingData(successMock, _serviceName);
  });

  test('For LoadingBloc class ==> mapLoadingData() failure ', () async {
    bloc.loadingUseCasesImpl = failureMock;
    bloc.mapLoadingData(failureMock, _serviceName);

    Either<Failure, LoadingModelData> result =
        (await failureMock.getLoadingData(_serviceName))!;

    expect(result.isLeft, true);
    expect(bloc.state.loadingViewModelState, LoadingViewModelState.failure);
  });

  test('For LoadingBloc class ==> mapLoadingData() Null ', () async {
    bloc.loadingUseCasesImpl = nullMock;
    bloc.mapLoadingData(nullMock, _serviceName);

    Either<Failure, LoadingModelData> result =
        (await nullMock.getLoadingData(_serviceName))!;

    expect(result.isRight, true);
    expect(bloc.state.loadingViewModelState, LoadingViewModelState.failure);
  });

  test('For LoadingBloc class ==> mapLoadingData() success ', () async {
    bloc.loadingUseCasesImpl = successMock;
    bloc.mapLoadingData(successMock, _serviceName);

    Either<Failure, LoadingModelData> result =
        (await successMock.getLoadingData(_serviceName))!;

    expect(result.isRight, true);
    expect(bloc.state.loadingViewModelState, LoadingViewModelState.loaded);
  });
}
