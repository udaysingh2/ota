import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preference_popup/repositories/preference_popup_repository.dart';

/// Interface for HotelDetail use cases.
abstract class PreferencePopUpUseCases {
  Future<Either<Failure, bool?>?> getPopUpState(
      String id, String type, String endDate);
}

class PreferencePopUpUseCasesImpl implements PreferencePopUpUseCases {
  PreferencePopUpRepository? preferencePopUpRepository;

  /// Dependence injection via constructor
  PreferencePopUpUseCasesImpl({PreferencePopUpRepository? repository}) {
    if (repository == null) {
      preferencePopUpRepository = PreferencePopUpRepositoryImpl();
    } else {
      preferencePopUpRepository = repository;
    }
  }

  @override
  Future<Either<Failure, bool?>?> getPopUpState(
      String id, String type, String endDate) async {
    return await preferencePopUpRepository?.getPopUpState(id, type, endDate);
  }
}
