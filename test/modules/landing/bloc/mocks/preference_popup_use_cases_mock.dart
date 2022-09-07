import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preference_popup/usecases/preference_popup_usecase.dart';

class PreferencePopupUseCasesSuccessMock extends PreferencePopUpUseCasesImpl {

  @override
  Future<Either<Failure, bool?>?> getPopUpState(
      String id, String type, String endDate) async {
    return const Right(true);
  }
}
