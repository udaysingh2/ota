import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/popup/models/popup_models.dart';
import 'package:ota/domain/popup/usecases/popup_usecases.dart';

class PopupUseCasesAllSuccessMock extends PopupUseCasesImpl {
  @override
  Future<Either<Failure, PopupModelDomain?>?> getPopup() async {
    return Right(
      PopupModelDomain(
        getPopups: GetPopups(
          data: GetPopupsData(
            popups: [
              Popup(),
            ],
          ),
        ),
      ),
    );
  }
}

class PopupUseCasesPopUpNullEmptyMock extends PopupUseCasesImpl {
  @override
  Future<Either<Failure, PopupModelDomain?>?> getPopup() async {
    return Right(
      PopupModelDomain(
        getPopups: GetPopups(
          data: GetPopupsData(
            popups: [],
          ),
        ),
      ),
    );
  }
}

class PopupUseCasesFailureMock extends PopupUseCasesImpl {
  @override
  Future<Either<Failure, PopupModelDomain?>?> getPopup() async {
    return Left(InternetFailure());
  }
}
