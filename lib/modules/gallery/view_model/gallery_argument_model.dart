import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';

class GalleryArgument {
  String serviceName;
  String serviceId;
  GalleryArgument({required this.serviceName, required this.serviceId});

  GalleryArgumentDomain toGalleryDataArgumentDomain() {
    return GalleryArgumentDomain(
        serviceId: serviceId, serviceName: serviceName);
  }
}
