import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/popup/models/popup_models.dart';
import 'package:ota/domain/popup/repositories/popup_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class PopupUseCases {
  Future<Either<Failure, PopupModelDomain?>?> getPopup();
}

class PopupUseCasesImpl implements PopupUseCases {
  PopupRepository? popupRepository;

  /// Dependence injection via constructor
  PopupUseCasesImpl({PopupRepository? repository}) {
    if (repository == null) {
      popupRepository = PopupRepositoryImpl();
    } else {
      popupRepository = repository;
    }
  }

  @override
  Future<Either<Failure, PopupModelDomain?>?> getPopup() async {
    return await popupRepository?.getPopup();
  }
}
