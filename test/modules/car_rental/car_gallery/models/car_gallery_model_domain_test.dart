import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  group('Car Gallery Model Domain ', () {
    String json = fixture("car_gallery/image_model.json");
    String json2 = fixture("car_gallery/get_all_car_rental_images_data.json");
    String json3 = fixture("car_gallery/get_all_car_rental_images.json");
    String json4 = fixture("car_gallery/car_gallery_model_domain.json");

    test('Car Gallery Image Model', () async {
      ///Convert into Model
      Image model = Image.fromJson(json);
      expect(model.full != null, true);

      ///convert into map
      Map<String, dynamic> map = model.toMap();

      ///Check map conversion
      Image mapFromModel = Image.fromMap(map);
      expect(mapFromModel.full != null, true);

      ///Convert to String
      String stringData = model.toString();
      expect(stringData.isNotEmpty, true);

      ///Convert to json
      String jsondata = model.toJson();
      expect(jsondata.isNotEmpty, true);
    });

    test('Car Gallery CAR RENTAL IMAGES DATA Model', () {
      ///Convert into Model
      GetAllCarRentalImagesData model2 =
          GetAllCarRentalImagesData.fromJson(json2);
      expect(model2.id != null, true);

      ///convert into map
      Map<String, dynamic> map = model2.toMap();

      ///Check map conversion
      GetAllCarRentalImagesData mapFromModel =
          GetAllCarRentalImagesData.fromMap(map);
      expect(mapFromModel.images != null, true);

      ///Convert to String
      String stringData = model2.toString();
      expect(stringData.isNotEmpty, true);

      ///Convert to json
      String jsondata = model2.toJson();
      expect(jsondata.isNotEmpty, true);
    });

    test('Car Gallery CAR RENTAL IMAGES Model', () {
      ///Convert into Model
      GetAllCarRentalImages model3 = GetAllCarRentalImages.fromJson(json3);
      expect(model3.data != null, true);

      ///convert into map
      Map<String, dynamic> map = model3.toMap();

      ///Check map conversion
      GetAllCarRentalImages mapFromModel = GetAllCarRentalImages.fromMap(map);
      expect(mapFromModel.data != null, true);

      ///Convert to String
      String stringData = model3.toString();
      expect(stringData.isNotEmpty, true);

      ///Convert to json
      String jsondata = model3.toJson();
      expect(jsondata.isNotEmpty, true);
    });

    test('Car Gallery Domain Model', () {
      ///Convert into Model
      CarGalleryModelDomain model4 = CarGalleryModelDomain.fromJson(json4);
      expect(model4.getAllCarRentalImages != null, true);

      ///convert into map
      Map<String, dynamic> map = model4.toMap();

      ///Check map conversion
      CarGalleryModelDomain mapFromModel = CarGalleryModelDomain.fromMap(map);
      expect(mapFromModel.getAllCarRentalImages != null, true);

      ///Convert to String
      String stringData = model4.toString();
      expect(stringData.isNotEmpty, true);

      ///Convert to json
      String jsondata = model4.toJson();
      expect(jsondata.isNotEmpty, true);
    });
  });
}
