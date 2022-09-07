import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/repositories/hotel_dynamic_playlist_repository_impl.dart';

abstract class CarSearchSuggestionUseCases {
  Future<Either<Failure, CarSearchSuggestionData>?> getCarSearchSuggestionData(
      {CarSearchSuggestionArgumentModelDomain argument});
}

/// CarSearchSuggestionUseCasesImpl will contain the CarSearchSuggestionUseCases implementation.
class CarSearchSuggestionUseCasesImpl implements CarSearchSuggestionUseCases {
  CarSearchSuggestionRepository? carSearchSuggestionRepository;
  HotelDynamicPlaylistRepository? hotelDynamicPlaylistRepository;

  /// Dependence injection via constructor
  CarSearchSuggestionUseCasesImpl({CarSearchSuggestionRepository? repository}) {
    if (repository == null) {
      carSearchSuggestionRepository = CarSearchSuggestionRepositoryImpl();
    } else {
      carSearchSuggestionRepository = repository;
    }
  }

  @override
  Future<Either<Failure, CarSearchSuggestionData>?> getCarSearchSuggestionData(
      {CarSearchSuggestionArgumentModelDomain? argument}) async {
    return await carSearchSuggestionRepository
        ?.getCarSearchSuggestionData(argument!);
  }
}
