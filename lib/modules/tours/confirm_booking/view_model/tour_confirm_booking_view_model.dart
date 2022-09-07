import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';
import 'package:ota/modules/tours/confirm_booking/helper/tour_booking_confirm_helper.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

const String _kDefaultNumberOfDays = "1";

class TourConfirmBookingViewModel {
  TourPaymentReviewViewModelStates state;
  final String? bookingUrn;
  final String? tourId;
  final String? cityId;
  final String? countryId;
  final DateTime? bookingDate;
  final String? name;
  final String? image;
  final String? location;
  final String? category;
  final String? noOfDays;
  final String? startTimeAmPm;
  final PackageDetailViewModel? packageDetail;
  final double? totalAmount;
  final double? totalFees;
  final double? totalTaxes;
  final double? totalDiscount;
  double promoDiscount;
  final List<ParticipantInfoViewModel>? participantInfo;
  final CustomerInfoViewModel? customerInfo;
  final ToursChildInfoViewModel? childInfo;
  final int? adultCount;
  final int? childCount;
  final double? adultPrice;
  final double? childPrice;
  final String? cancellationPolicy;
  final bool? isAllTravellersInfoRequired;
  final List<OtaFreeFoodPromotionModel> promotionData;

  TourConfirmBookingViewModel({
    required this.state,
    this.promoDiscount = 0.0,
    this.bookingUrn,
    this.tourId,
    this.cityId,
    this.countryId,
    this.bookingDate,
    this.name,
    this.image,
    this.location,
    this.category,
    this.noOfDays,
    this.startTimeAmPm,
    this.packageDetail,
    this.totalAmount,
    this.totalFees,
    this.totalTaxes,
    this.totalDiscount,
    this.participantInfo,
    this.customerInfo,
    this.childInfo,
    this.adultCount,
    this.childCount,
    this.adultPrice,
    this.childPrice,
    this.cancellationPolicy,
    this.isAllTravellersInfoRequired,
    this.promotionData = const [],
  });

  factory TourConfirmBookingViewModel.fromData(
          {required TourConfirmBookingData data,
          required ToursChildInfo childInfo,
          required int adultCount,
          required int childCount,
          required double adultPrice,
          required double childPrice,
          required String cancellationPolicy,
          required bool isAllTravellersInfoRequired}) =>
      TourConfirmBookingViewModel(
        state: TourPaymentReviewViewModelStates.success,
        bookingUrn: data.bookingUrn,
        tourId: data.tourId,
        cityId: data.cityId,
        promoDiscount: 0.0,
        countryId: data.countryId,
        bookingDate: data.bookingDate,
        name: data.name,
        image: data.image,
        location: data.location,
        category: data.category,
        // putting no of Days as 1 as done in review reservation as a part of OTA-4182
        noOfDays: data.noOfDays ?? _kDefaultNumberOfDays,
        startTimeAmPm: data.startTimeAmPm,
        packageDetail:
            PackageDetailViewModel.fromPackageDetail(data.packageDetail!),
        totalAmount: data.totalAmount,
        totalFees: data.totalFees,
        totalTaxes: data.totalTaxes,
        totalDiscount: data.totalDiscount,
        participantInfo: TourConfirmBookingHelper.getParticipantInfo(data),
        customerInfo: TourConfirmBookingHelper.getCustomerInfo(data),
        adultCount: adultCount,
        childCount: childCount,
        adultPrice: adultPrice,
        childPrice: childPrice,
        childInfo: ToursChildInfoViewModel.mapFromChildInfo(childInfo),
        cancellationPolicy: cancellationPolicy,
        isAllTravellersInfoRequired: isAllTravellersInfoRequired,
        promotionData: data.promotionList != null &&
                data.promotionList!.isNotEmpty
            ? List.generate(
                data.promotionList!.length,
                (index) => OtaFreeFoodPromotionModel(
                  deepLinkUrl: data.promotionList![index].web ?? "",
                  headerText: data.promotionList![index].title ?? "",
                  subHeaderText: data.promotionList![index].description ?? "",
                  headerIcon: data.promotionList![index].iconImage ?? "",
                  promotionCode: data.promotionList![index].promotionCode ?? "",
                  line1: data.promotionList![index].line1 ?? "",
                ),
              )
            : [],
      );
}

class PackageDetailViewModel {
  PackageDetailViewModel({
    this.name,
    this.highlights,
    this.cancellationPolicy,
    this.durationText,
    this.duration,
  });

  final String? name;
  final List<TourHighlightViewModel>? highlights;
  final String? cancellationPolicy;
  final String? durationText;
  final String? duration;

  factory PackageDetailViewModel.fromPackageDetail(PackageDetail package) =>
      PackageDetailViewModel(
        name: package.name,
        highlights: TourConfirmBookingHelper.getHighlights(package),
        cancellationPolicy: package.cancellationPolicy,
        durationText: package.durationText,
        duration: package.duration,
      );
}

class ParticipantInfoViewModel {
  ParticipantInfoViewModel({
    this.paxId,
    this.name,
    this.surname,
    this.weight,
    this.dateOfBirth,
    this.passportCountry,
    this.passportNumber,
    this.passportCountryIssue,
    this.expiryDate,
  });

  final String? paxId;
  final String? name;
  final String? surname;
  final double? weight;
  final String? dateOfBirth;
  final String? passportCountry;
  final String? passportNumber;
  final String? passportCountryIssue;
  final String? expiryDate;

  factory ParticipantInfoViewModel.fromParticipantInfo(ParticipantInfo info) =>
      ParticipantInfoViewModel(
        paxId: info.paxId,
        name: info.name,
        surname: info.surname,
        weight: info.weight,
        dateOfBirth: info.dateOfBirth,
        passportCountry: info.passportCountry,
        passportNumber: info.passportNumber,
        passportCountryIssue: info.passportCountryIssue,
        expiryDate: info.expiryDate,
      );
}

class TourHighlightViewModel {
  TourHighlightViewModel({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory TourHighlightViewModel.fromHighLight(Highlight? highlight) =>
      TourHighlightViewModel(
        key: highlight?.key,
        value: highlight?.value,
      );
}

class CustomerInfoViewModel {
  CustomerInfoViewModel({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  factory CustomerInfoViewModel.fromCustomerInfo(CustomerInfo info) =>
      CustomerInfoViewModel(
        email: info.email,
        firstName: info.firstName,
        lastName: info.lastName,
        phoneNumber: info.phoneNumber,
      );
}

class ToursChildInfoViewModel {
  final int? minAge;
  final int? maxAge;

  ToursChildInfoViewModel({
    this.minAge,
    this.maxAge,
  });

  factory ToursChildInfoViewModel.mapFromChildInfo(ToursChildInfo? childInfo) =>
      ToursChildInfoViewModel(
        minAge: childInfo?.minAge,
        maxAge: childInfo?.maxAge,
      );
}

class TourPaymentRoom {
  int adults;
  int children;
  int? childAge1;
  int? childAge2;

  TourPaymentRoom({
    required this.adults,
    required this.children,
    this.childAge1,
    this.childAge2,
  });
}

enum TourPaymentReviewViewModelStates {
  initial,
  loading,
  success,
  failure,
  internetFailure,
}
