import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_view_model.dart';

void main() {
  test(
    'Car Rental View Argument Tests',
    () async {
      CarVerticalArgumentViewModel carVerticalArgumentViewModel =
          CarVerticalArgumentViewModel(
        styleName: "",
        capsulePromotion: [],
        promotionTextLineTwo: "",
        promotionTextLineOne: "",
        locationName: "",
        craftType: "",
        carModel: null,
        imageUrl: "",
        name: "",
        id: "",
      );
      expect(carVerticalArgumentViewModel.id, '');
      expect(carVerticalArgumentViewModel.styleName, '');
      expect(carVerticalArgumentViewModel.locationName, '');
      expect(carVerticalArgumentViewModel.craftType, '');
      expect(carVerticalArgumentViewModel.imageUrl, '');
      expect(carVerticalArgumentViewModel.name, '');
      expect(carVerticalArgumentViewModel.id, '');
    },
  );

  test("Car Rental Vertical Playlist Model From Card Test", () {
    CarVerticalArgumentViewModel carVerticalArgumentViewModel =
        CarVerticalArgumentViewModel.fromCard(
            CarModelList(
              brandId: 1,
              brandName: "",
              capsulePromotion: [],
              carId: 1,
              carInfo: CarInfo(carTypeId: 1, carTypeName: ""),
              images: Images(full: "", thumb: ""),
              modelName: "",
              overlayPromotion: OverlayPromotion(
                  adminPromotionLine1: "", adminPromotionLine2: ""),
            ),
            Counter());

    expect(carVerticalArgumentViewModel.id, '');
    expect(carVerticalArgumentViewModel.styleName, '');
  });
  test("Car rental vertical playlist view model test", () {
    CarRentalVerticalData carRentalVerticalData = CarRentalVerticalData();
    CarVerticalListViewModel carVerticalListViewModel =
        CarVerticalListViewModel(
      pageState: CarVerticalListPageState.success,
      carRentalVerticalData: carRentalVerticalData,
    );
    expect(
        carVerticalListViewModel.pageState, CarVerticalListPageState.success);
    expect(
        carVerticalListViewModel.carRentalVerticalData, carRentalVerticalData);
  });

  test("Car Rental Vertical Data test", () {
    CarRental carRental = CarRental(
      carModelList: [],
      pickupLocationId: "",
      returnLocationId: "",
    );
    CarRentalVerticalData carRentalVerticalData =
        CarRentalVerticalData.fromCarRentalModel(carRental);
    expect(carRentalVerticalData.carModelList, []);
    expect(carRentalVerticalData.pickupLocationId, "");
    expect(carRentalVerticalData.returnLocationId, "");
  });

  test("Car Vertical List", () {
    CarModelList carModelList = CarModelList(
      carId: 1234,
      brandName: "",
      suppliers: [],
    );
    CarVerticalList carVerticalList =
        CarVerticalList.fromCarVerticalList(carModelList);
    expect(carVerticalList.carId, 1234);
    expect(carVerticalList.brandName, "");
    expect(carVerticalList.suppliers, []);
  });

  test("Car Vertical Info test", () {
    CarInfo carInfo = CarInfo(
      carTypeId: 123,
      carTypeName: "",
    );
    CarVerticalInfo carVerticalInfo = CarVerticalInfo.fromCarInfo(carInfo);
    expect(carVerticalInfo.carTypeId, 123);
    expect(carVerticalInfo.carTypeName, "");
  });

  test("Overlay Promotion Model test", () {
    OverlayPromotion overlayPromotion = OverlayPromotion(
      adminPromotionLine2: "",
      adminPromotionLine1: "",
    );
    OverlayPromotionModel overlayPromotionModel =
        OverlayPromotionModel.fromOverlayPromotion(overlayPromotion);
    expect(overlayPromotionModel.adminPromotionLine1, "");
    expect(overlayPromotionModel.adminPromotionLine2, "");
  });

  test("Capsule Promotion Model test", () {
    CapsulePromotion capsulePromotion = CapsulePromotion(
      name: "",
      code: "",
    );
    CapsulePromotionModel capsulePromotionModel =
        CapsulePromotionModel.fromCapsulePromotionModel(capsulePromotion);
    expect(capsulePromotionModel.name, "");
    expect(capsulePromotionModel.code, "");
  });

  test("Images Model test", () {
    Images images = Images(
      full: "",
      thumb: "",
    );
    ImagesModel imagesModel = ImagesModel.fromImagesModel(images);
    expect(imagesModel.full, "");
    expect(imagesModel.thumb, "");
  });

  test("Supplier Model test", () {
    Counter counter = Counter();
    Supplier supplier = Supplier(
      pickupCounter: counter,
      returnCounter: counter,
    );
    SupplierModel.fromSupplier(supplier);
  });

  test("CounterModel test", () {
    Counter counter = Counter(
      locationId: "",
      name: "",
    );
    CounterModel counterModel = CounterModel.fromCounter(counter);
    expect(counterModel.locationId, "");
    expect(counterModel.name, "");
  });
}
