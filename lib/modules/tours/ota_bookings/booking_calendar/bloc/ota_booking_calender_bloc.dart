import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/details/usecases/tours_details_usecases.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/helpers/ota_booking_calendar_helper.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_argument.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_view_model.dart';

class OtaBookingCalendarBloc extends Bloc<TourBookingCalendarViewModel> {
  @override
  TourBookingCalendarViewModel initDefaultValue() {
    return TourBookingCalendarViewModel(
      tourPackageModel: TourPackageModel(),
    );
  }

  void initDetails(String name, double adultPrice, double childPrice,
      int availableSeats, int minimumSeats) {
    state.tourPackageModel.packageName = name;
    state.tourPackageModel.adultPrice = adultPrice;
    state.tourPackageModel.childPrice = childPrice;
    state.tourPackageModel.totalPrice = adultPrice;
    state.tourPackageModel.availableSeats = availableSeats;
    state.tourPackageModel.minimumSeats = minimumSeats;
    state.bookingCalendarState = BookingCalendarState.initial;
    emit(state);
  }

  void getTourPackageDetails(TourBookingCalendarArgument? argument) async {
    if (argument == null) {
      state.bookingCalendarState = BookingCalendarState.failure;
      emit(state);
      return;
    }

    TourDetailsUseCasesImpl tourDetailsUseCases = TourDetailsUseCasesImpl();
    Either<Failure, TourDetail>? result = await tourDetailsUseCases
        .getTourPackageDetails(argument.toTourPackageDomainArgument());

    if (result?.isRight ?? false) {
      TourDetail data = result!.right;
      String? statusCode = data.getTourDetails?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.bookingCalendarState = BookingCalendarState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.bookingCalendarState = BookingCalendarState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        Tour? tourDetail = data.getTourDetails?.data?.tour;
        if (tourDetail != null) {
          final packages = tourDetail.packages;
          if (packages == null) {
            state.bookingCalendarState = BookingCalendarState.noPackage;
            emit(state);
            return;
          }
          if (packages.isEmpty) {
            state.bookingCalendarState = BookingCalendarState.noPackage;
            emit(state);
            return;
          }
          if (packages.first.availableSeats == 0) {
            state.bookingCalendarState = BookingCalendarState.packageFullSold;
            emit(state);
            return;
          }
          state.tourPackageModel =
              OtaBookingCalendarHelper.fromTourPackage(packages.first);
          state.bookingCalendarState = BookingCalendarState.success;
          emit(state);
        } else {
          _emitFailure();
        }
      } else {
        _emitFailure();
      }
    } else {
      if (result?.left is InternetFailure) {
        state.bookingCalendarState = BookingCalendarState.failureNetwork;
        emit(state);
      } else {
        _emitFailure();
      }
    }
  }

  void _emitFailure() {
    state.bookingCalendarState = BookingCalendarState.failure;
    emit(state);
  }

  void updateAdults(int count) {
    tourPackage.adultCount = count;
    tourPackage.totalPrice = tourTotalPrice;
    emit(state);
  }

  void addChild(int count, int age) {
    tourPackage.childCount = tourPackage.childCount + count;
    tourPackage.childAgeList.add(age);
    tourPackage.totalPrice = tourTotalPrice;
    emit(state);
  }

  void removeChild(int count) {
    tourPackage.childCount = tourPackage.childCount - count;
    tourPackage.childAgeList.removeLast();
    tourPackage.totalPrice = tourTotalPrice;
    emit(state);
  }

  void updateChild(int index, int newAge) {
    tourPackage.childAgeList[index] = newAge;
    emit(state);
  }

  double get tourTotalPrice {
    return (tourPackage.adultPrice * tourPackage.adultCount) +
        (tourPackage.childPrice * tourPackage.childCount);
  }

  int get totalSelectedTravellers =>
      tourPackage.adultCount + tourPackage.childCount;

  int get totalAdultTravellers => tourPackage.adultCount;

  TourPackageModel get tourPackage => state.tourPackageModel;

  bool get shouldShowChildTileWidget =>
      tourPackage.childMinAge != 0 && tourPackage.childMaxAge != 0;
}
