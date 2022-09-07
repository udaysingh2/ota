import 'package:ota/modules/preferences/view_model/preferences_argument_model.dart';

List<PreferencesArgumentModel> getPreferencesArgumentModel() {
  return [
    PreferencesArgumentModel(
      questionId: "A",
      backgroundImageUrl: "",
      description1: "What are your travel interests?",
      description2: "Please select one or more",
      multiChoice: true,
      options: [
        OptionArgumentModel(
          optionCode: "A1",
          optionDesc: "Waterfalls",
          imageUrl: "https://www.linkpicture.com/q/Preference_waterfall.png",
        ),
        OptionArgumentModel(
          optionCode: "A2",
          optionDesc: "Sea",
          imageUrl: "https://www.linkpicture.com/q/Preference_sea.png",
        ),
        OptionArgumentModel(
          optionCode: "A3",
          optionDesc: "Mountains",
          imageUrl: "https://www.linkpicture.com/q/Preference_mountain.png",
        ),
      ],
    ),
    PreferencesArgumentModel(
      questionId: "B",
      backgroundImageUrl: "",
      description1: "What are your travel interests?",
      description2: "Please select one or more",
      multiChoice: false,
      options: [
        OptionArgumentModel(
          optionCode: "C1",
          optionDesc: "Half day trip",
          imageUrl: "",
        ),
        OptionArgumentModel(
          optionCode: "C2",
          optionDesc: "One day trip",
          imageUrl: "",
        ),
        OptionArgumentModel(
          optionCode: "C3",
          optionDesc: "2 Days 1 night",
          imageUrl: "",
        ),
      ],
    )
  ];
}
