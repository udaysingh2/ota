import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/popup/models/popup_models.dart';
import 'package:ota/domain/popup/usecases/popup_usecases.dart';
import 'package:ota/modules/landing/bloc/popup_bloc.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';

import 'mocks/popup_use_cases_mock.dart';

void main() {
  PopupBloc bloc = PopupBloc();

  PopupUseCasesImpl successMock = PopupUseCasesAllSuccessMock();
  PopupUseCasesImpl popUpNullEmptyMock = PopupUseCasesPopUpNullEmptyMock();
  PopupUseCasesImpl failureMock = PopupUseCasesFailureMock();

  test('For PopupBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.popupViewModelState, PopupViewModelState.none);
  });

  group('For PopupBloc class ==> getPopupData()', () {
    test('If Failure then', () async {
      bloc.popupUseCases = failureMock;
      await bloc.getPopupData();

      Either<Failure, PopupModelDomain?>? result = await failureMock.getPopup();

      expect(result?.isLeft, true);
      expect(bloc.state.popupViewModelState, PopupViewModelState.failure);
    });

    test('if argument has all valid data but popup is NULL then', () async {
      bloc.popupUseCases = popUpNullEmptyMock;
      await bloc.getPopupData();

      Either<Failure, PopupModelDomain?>? result =
          await popUpNullEmptyMock.getPopup();

      expect(result?.isRight, true);
      expect(bloc.state.popupViewModelState, PopupViewModelState.failure);
    });

    test('if argument has all valid data then', () async {
      bloc.popupUseCases = successMock;
      await bloc.getPopupData();

      Either<Failure, PopupModelDomain?>? result = await successMock.getPopup();

      expect(result?.isRight, true);
      expect(bloc.state.popupViewModelState, PopupViewModelState.success);
    });
  });
}
