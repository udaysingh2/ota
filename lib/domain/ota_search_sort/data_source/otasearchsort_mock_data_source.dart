import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';

/// OtaSearchSortMockDataSourceImpl will contain the OtaSearchSortMockDataSource implementation.
class OtaSearchSortMockDataSourceImpl implements OtaSearchSortRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  OtaSearchSortMockDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the OtaSearchSort Screen details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  @override
  Future<OtaFilterSort> getOtaSearchSortData() async {
    return OtaFilterSort.fromJson(jsonData);
  }

  String jsonData = """
  {
  "status": {
    "code": "1000",
    "header": "",
    "description": "success"
  },
  "data": {
    "sortInfo": [
      {
        "displayTitle": "Robinhood suggestion",
        "sortSeq": 1,
        "value": "rbh_suggest"
      },
      {
        "displayTitle": "Popular",
        "sortSeq": 2,
        "value": "rbh_popular"
      },
      {
        "displayTitle": "Low price to high price",
        "sortSeq": 3,
        "value": "price_ascending"
      },
      {
        "displayTitle": "High price to Low price",
        "sortSeq": 4,
        "value": "price_descending"
      },
      {
        "displayTitle": "Review score",
        "sortSeq": 5,
        "value": "review_descending"
      },
      {
        "displayTitle": "Star rating",
        "sortSeq": 6,
        "value": "rating_descending"
      }
    ],
    "criteria": [
      {
        "displayTitle": "Promotion",
        "sortSeq": 1,
        "value": "criteria_rbh_pro"
      },
      {
        "displayTitle": "Price",
        "sortSeq": 2,
        "value": "criteria_price"
      },
      {
        "displayTitle": "Review",
        "sortSeq": 3,
        "value": "criteria_review"
      },
      {
        "displayTitle": "Star",
        "sortSeq": 4,
        "value": "criteria_star"
      }
    ]
  }
}
  """;
}
