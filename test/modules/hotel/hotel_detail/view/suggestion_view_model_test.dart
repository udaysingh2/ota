import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/suggetion_view_model.dart';

void main() {
  test('Suggestions Model Test constructor', () {
    SuggetionViewModel suggetionViewModel = SuggetionViewModel();
    expect(suggetionViewModel.headerText, null);
    expect(suggetionViewModel.ratingText, null);
    expect(suggetionViewModel.addressText, null);
    expect(suggetionViewModel.ratingTitle, null);
    expect(suggetionViewModel.reviewText, null);
    expect(suggetionViewModel.offerPercent, null);
    expect(suggetionViewModel.discount, null);
    expect(suggetionViewModel.imageUrl, null);
  });
  test('Suggestions Model Test constructor with static data', () {
    SuggetionViewModel suggetionViewModel = SuggetionViewModel(
        headerText: "Header Text",
        ratingText: "Rating Text",
        addressText: "Address Text",
        ratingTitle: "Rating Title",
        reviewText: "Review Text",
        offerPercent: "Offer Percent",
        discount: "Discount",
        imageUrl: "Image Url");
    expect(suggetionViewModel.headerText, "Header Text");
    expect(suggetionViewModel.ratingText, "Rating Text");
    expect(suggetionViewModel.addressText, "Address Text");
    expect(suggetionViewModel.ratingTitle, "Rating Title");
    expect(suggetionViewModel.reviewText, "Review Text");
    expect(suggetionViewModel.offerPercent, "Offer Percent");
    expect(suggetionViewModel.discount, "Discount");
    expect(suggetionViewModel.imageUrl, "Image Url");
  });
}
