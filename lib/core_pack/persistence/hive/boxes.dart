import 'package:hive/hive.dart';

import '../../../modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

//DO NOT CHANGE
class OTAHiveBoxes{
  static Box<CarRecentSearchData> getRecentSearches() => Hive.box<CarRecentSearchData>(BoxKeys.kRecentSearchBox);
}


class BoxKeys{
  //DO NOT CHANGE
  static String kRecentSearchBox = "recentSearches";
}


class ModelTypeId{
  static const int carRecentSearchDataModel = 1;
}

