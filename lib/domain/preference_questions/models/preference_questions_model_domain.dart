import 'dart:convert';

class PreferenceQuestionsModelDomain {
  PreferenceQuestionsModelDomain({
    this.data,
  });

  final PreferenceQuestionsModelDomainData? data;

  factory PreferenceQuestionsModelDomain.fromJson(String str) =>
      PreferenceQuestionsModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PreferenceQuestionsModelDomain.fromMap(Map<String, dynamic> json) =>
      PreferenceQuestionsModelDomain(
        data: json["data"] == null
            ? null
            : PreferenceQuestionsModelDomainData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class PreferenceQuestionsModelDomainData {
  PreferenceQuestionsModelDomainData({
    this.getPreferences,
  });

  final GetPreferences? getPreferences;

  factory PreferenceQuestionsModelDomainData.fromJson(String str) =>
      PreferenceQuestionsModelDomainData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PreferenceQuestionsModelDomainData.fromMap(
          Map<String, dynamic> json) =>
      PreferenceQuestionsModelDomainData(
        getPreferences: json["getPreferences"] == null
            ? null
            : GetPreferences.fromMap(json["getPreferences"]),
      );

  Map<String, dynamic> toMap() => {
        "getPreferences": getPreferences?.toMap(),
      };
}

class GetPreferences {
  GetPreferences({
    this.data,
    this.status,
  });

  final GetPreferencesData? data;
  final Status? status;

  factory GetPreferences.fromJson(String str) =>
      GetPreferences.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPreferences.fromMap(Map<String, dynamic> json) => GetPreferences(
        data: json["data"] == null
            ? null
            : GetPreferencesData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetPreferencesData {
  GetPreferencesData({
    this.preferences,
  });

  final List<Preference>? preferences;

  factory GetPreferencesData.fromJson(String str) =>
      GetPreferencesData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPreferencesData.fromMap(Map<String, dynamic> json) =>
      GetPreferencesData(
        preferences: json["preferences"] == null
            ? null
            : List<Preference>.from(
                json["preferences"].map((x) => Preference.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "preferences": preferences == null
            ? null
            : List<dynamic>.from(preferences!.map((x) => x.toMap())),
      };
}

class Preference {
  Preference({
    this.questionId,
    this.description1,
    this.description2,
    this.backgroundImageUrl,
    this.multiChoice,
    this.minNum,
    this.options,
  });

  final String? questionId;
  final String? description1;
  final String? description2;
  final String? backgroundImageUrl;
  final bool? multiChoice;
  final int? minNum;
  final List<Option>? options;

  factory Preference.fromJson(String str) =>
      Preference.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Preference.fromMap(Map<String, dynamic> json) => Preference(
        questionId: json["questionId"],
        description1: json["description1"],
        description2: json["description2"],
        backgroundImageUrl: json["backgroundImageUrl"],
        multiChoice: json["multiChoice"],
        minNum: json["minNum"],
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "questionId": questionId,
        "description1": description1,
        "description2": description2,
        "backgroundImageUrl": backgroundImageUrl,
        "multiChoice": multiChoice,
        "minNum": minNum,
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toMap())),
      };
}

class Option {
  Option({
    this.imageUrl,
    this.optionCode,
    this.optionDesc,
  });

  final String? imageUrl;
  final String? optionCode;
  final String? optionDesc;

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
        imageUrl: json["imageUrl"],
        optionCode: json["optionCode"],
        optionDesc: json["optionDesc"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl ?? imageUrl,
        "optionCode": optionCode ?? optionCode,
        "optionDesc": optionDesc ?? optionDesc,
      };
}

class Status {
  Status({
    this.code,
    this.description,
  });

  final String? code;
  final String? description;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"] ?? json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code ?? code,
        "description": description,
      };
}
