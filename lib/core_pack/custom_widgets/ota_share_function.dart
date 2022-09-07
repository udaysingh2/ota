import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:share_plus/share_plus.dart';

const String _baseUrl =
    'https://static.robinhood.in.th/share_link_ota.html?URI=';
const String _staticUri = 'robinhoodth://otalanding?';

class OtaShareFunction {
  void otaShareClicked(
      {required String serviceType,
      required String shareText,
      String? productId,
      String? countryId,
      String? cityId,
      String? pickupLocation,
      String? pickUpCounter,
      String? returnLocation,
      String? returnCounter,
      String? supplierId}) {
    String? param = _generateUrl(
        productId: productId,
        serviceType: serviceType,
        cityId: cityId,
        countryId: countryId,
        pickUpCounter: pickUpCounter,
        returnCounter: returnCounter,
        returnLocation: returnLocation,
        pickupLocation: pickupLocation,
        supplierId: supplierId);

    if (param != null && param.isNotEmpty) {
      Share.share('$shareText \n$_baseUrl$_staticUri$param');
    }
  }

  String? _generateUrl({
    required String serviceType,
    String? productId,
    String? countryId,
    String? cityId,
    String? pickupLocation,
    String? pickUpCounter,
    String? returnLocation,
    String? returnCounter,
    String? supplierId,
  }) {
    switch (serviceType) {
      case OtaServiceType.hotel:
        return _generateServiceUri(serviceType, productId, cityId, countryId);
      case OtaServiceType.activity:
        return _generateServiceUri(serviceType, productId, cityId, countryId);
      case OtaServiceType.ticket:
        return _generateServiceUri(serviceType, productId, cityId, countryId);
      case OtaServiceType.carRental:
        return _generateCarUri(serviceType, productId, pickupLocation,
            pickUpCounter, returnLocation, returnCounter, supplierId);
      default:
        return null;
    }
  }

  String? _generateServiceUri(String serviceName, String? productId,
      String? cityId, String? countryId) {
    if ((productId == null || productId.isEmpty) &&
        (cityId == null || cityId.isEmpty) &&
        (countryId == null || countryId.isEmpty)) {
      return null;
    }
    return 'id=$productId&cityId=$cityId&countryId=$countryId&serviceName=$serviceName';
  }

  String? _generateCarUri(
      String serviceName,
      String? productId,
      String? pickupLocation,
      String? pickUpCounter,
      String? returnLocation,
      String? returnCounter,
      String? supplierId) {
    if ((productId == null || productId.isEmpty) &&
        (pickupLocation == null || pickupLocation.isEmpty) &&
        (pickUpCounter == null || pickUpCounter.isEmpty) &&
        (returnLocation == null || returnLocation.isEmpty) &&
        (returnCounter == null || returnCounter.isEmpty)) {
      return null;
    }
    return 'id=$productId${'-'}$supplierId&pickupLocation=$pickupLocation&returnLocation=$returnLocation&pickupCounter=$pickUpCounter&returnCounter=$returnCounter&serviceName=$serviceName';
  }
}
