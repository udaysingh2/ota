class GetAppsFlyerModelChannel {
  GetAppsFlyerModelChannel({
    required this.eventName,
    required this.parameters,
    required this.language,
    required this.env,
  });

  final String eventName;
  final Map<String, String> parameters;
  final String language;
  final String env;

  Map<String, dynamic> toMap() => {
        "eventName": eventName,
        "parameters": List.generate(
            parameters.keys.length,
            (index) => {
                  "key": parameters.keys.elementAt(index),
                  "value": parameters.values.elementAt(index)
                }),
        "language": language,
        "env": env,
      };
}
