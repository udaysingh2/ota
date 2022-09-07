class PreferencesSubmitViewModel {
  String statusCode;
  PreferencesSubmitStatus preferencesSubmitStatus;
  PreferencesSubmitViewModel({
    this.statusCode = '',
    this.preferencesSubmitStatus = PreferencesSubmitStatus.none,
  });
}

enum PreferencesSubmitStatus { none, loading, success, failure }
