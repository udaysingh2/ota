import 'package:ota/common/network/failures.dart';
import 'package:either_dart/src/either.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/repositories/ota_search_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class OtaSearchRepositoryImplSuccessMock implements OtaSearchRepositoryImpl {
  @override
  Future<Either<Failure, OtaSearchData>> getOtaSearchData(
      OtaSearchDataArgument argument) async {
    String json = fixture("search/ota_search.json");
    final otaSearchResult = OtaSearchData.fromJson(json);
    return Right(otaSearchResult);
  }
}
