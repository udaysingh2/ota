import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';

class CarDetailInfoListingModel {
  final String imageUrl;
  final String header;
  final List<String> subHeaders;
  final bool isHtml;
  const CarDetailInfoListingModel({
    required this.imageUrl,
    required this.header,
    required this.subHeaders,
    this.isHtml = false,
  });
  factory CarDetailInfoListingModel.fromCarDetailInfoCell(
      CarDetailInfoCell data) {
    return CarDetailInfoListingModel(
      header: data.title,
      imageUrl: data.imagePath,
      isHtml: data.isHtmlField,
      subHeaders: [data.subTitle],
    );
  }
}
