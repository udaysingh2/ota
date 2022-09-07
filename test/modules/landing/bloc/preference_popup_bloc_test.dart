import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preference_popup/usecases/preference_popup_usecase.dart';
import 'package:ota/modules/landing/bloc/preference_popup_bloc.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';

import 'mocks/preference_popup_use_cases_mock.dart';

void main() {
  PreferencePopUpBloc bloc = PreferencePopUpBloc();
  PreferencePopUpUseCasesImpl successMock = PreferencePopupUseCasesSuccessMock();

  test('For PopupBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.popupViewModelState, PopupViewModelState.none);
  });

  test('For PopupBloc class ==> updatePopUpState() SUCCESS then ', () async {
    bloc.preferencePopUpUseCase = successMock;
    await bloc.updatePopUpState('', '', '');

    Either<Failure, bool?>? result = await successMock.getPopUpState('', '', '');

    expect(result?.isRight, true);
  });
}