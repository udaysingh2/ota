import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString =
      fixture("preference_questions/preference_questions_mock.json");
  PreferenceQuestionsModelDomain preferenceQuestionsResultModel =
      PreferenceQuestionsModelDomain.fromJson(jsonString);

  test("Preference Questions Models", () {
    //Convert into Model
    expect(preferenceQuestionsResultModel.data != null, true);

    //convert into map
    Map<String, dynamic> map = preferenceQuestionsResultModel.toMap();

    ///Check map conversion
    PreferenceQuestionsModelDomain mapFromModel =
        PreferenceQuestionsModelDomain.fromMap(map);

    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = preferenceQuestionsResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = preferenceQuestionsResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("getPreference", () {
    GetPreferences getPreferences = GetPreferences.fromJson(
        preferenceQuestionsResultModel.data!.getPreferences!.toJson());
    //convert into map
    Map<String, dynamic> map = getPreferences.toMap();
    expect(map.isNotEmpty, true);

    GetPreferences mapFromModel = GetPreferences.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
