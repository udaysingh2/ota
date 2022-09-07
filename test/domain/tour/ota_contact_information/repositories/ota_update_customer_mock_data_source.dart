// import 'dart:convert';
// import 'package:graphql/src/core/query_result.dart';
// import 'package:graphql/src/core/policies.dart';
// import 'package:ota/core_pack/graphql/graphql_client.dart';
// import '../../../../mocks/fixture_reader.dart';
//
// class MockOtaUpdateCustomerGraphQl implements GraphQlResponse {
//   Map<String, dynamic> map =
//   json.decode(fixture("tour/ota_contact_information_success_mock.json"));
//   @override
//   Future<QueryResult> getGraphQlResponse(
//       {String query = '',
//         FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
//         String? acceptLanguage,
//         bool authRequired = true}) async {
//     QueryResult queryResult =
//     QueryResult(source: QueryResultSource.optimisticResult, data: map,
//       parserFn: (Map<String, dynamic> data) {
//         return data;
//       },);
//     return queryResult;
//   }
// }
