import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';

/// Interface for Search use cases.
abstract class SearchSuggestionUseCases {
  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  Future<Either<Failure, SearchSuggestionModel>?> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt);
}

/// SearchUseCasesImpl will contain the SearchUseCases implementation.
class SearchSuggestionUseCasesImpl implements SearchSuggestionUseCases {
  SearchRepository? searchRepository;

  /// Dependence injection via constructor
  SearchSuggestionUseCasesImpl({SearchRepository? repository}) {
    if (repository == null) {
      searchRepository = SearchRepositoryImpl();
    } else {
      searchRepository = repository;
    }
  }

  /// Call API to get the Search Suggestion Screen Details details.
  ///
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, SearchSuggestionModel>?> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgument) async {
    return await searchRepository
        ?.getSearchSuggestionData(suggestionDataArgument);
  }
}
