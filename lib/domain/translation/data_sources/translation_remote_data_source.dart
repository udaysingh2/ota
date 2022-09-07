import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_translation.dart';
import 'package:ota/domain/translation/models/english_translation_data_model.dart';
import 'package:ota/domain/translation/models/thai_translation_data_model.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';

/// Interface for Hotel detail Data remote data source.
abstract class TranslationDataSource {
  Future<T> getTranslation<T>(TranslationArgumentModel argument);
}

class EnglishTranslationDataSourceImpl implements TranslationDataSource {
  GraphQlResponse? graphQlResponse;
  EnglishTranslationDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<T> getTranslation<T>(TranslationArgumentModel argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.loadTranslation,
        query: QueriesTranslation.getEnglishTranslationData(),
        acceptLanguage: argument.translationType.langCode());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      Map<String, dynamic> map = {};
      map["data"] = result.data!;
      return EnglishTranslationDataModel.fromMap(map) as T;
    }
  }
}

class ThaiTranslationDataSourceImpl implements TranslationDataSource {
  GraphQlResponse? graphQlResponse;
  ThaiTranslationDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<T> getTranslation<T>(TranslationArgumentModel argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.loadTranslation,
        query: QueriesTranslation.getThaiTranslationData(),
        acceptLanguage: argument.translationType.langCode());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      Map<String, dynamic> map = {};
      map["data"] = result.data!;
      return ThaiTranslationDataModel.fromMap(map) as T;
    }
  }
}
