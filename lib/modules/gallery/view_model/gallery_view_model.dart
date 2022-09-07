import 'dart:io';

import 'package:http/http.dart' as http;

Map<String, bool> _validImagesUrl = {};

class GalleryViewModel {
  final String imageUrl;
  bool isValid;

  GalleryViewModel({required this.imageUrl, this.isValid = false});

  factory GalleryViewModel.fromModel(String? baseUri, String? imgUrl) {
    String imagePathUrl = imgUrl ?? '';
    String basePathUri = baseUri ?? '';
    return GalleryViewModel(
        imageUrl: basePathUri + imagePathUrl, isValid: false);
  }

  Future<void> updateUrlStatus() async {
    if (_validImagesUrl.keys.contains(imageUrl)) {
      isValid = _validImagesUrl[imageUrl]!;
    } else {
      _validImagesUrl[imageUrl] = false;
      try {
        final response = await http.head(Uri.parse(imageUrl), headers: {
          "User-Agent": "Mozilla/4.0"
        }).timeout(const Duration(seconds: 10));
        if (response.statusCode == HttpStatus.ok) {
          isValid = true;
          _validImagesUrl[imageUrl] = true;
        } else {
          isValid = false;
        }
      } catch (exception) {
        isValid = false;
      }
    }
  }
}
