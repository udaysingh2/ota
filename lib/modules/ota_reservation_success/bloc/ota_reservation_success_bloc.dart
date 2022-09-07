import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_view_model.dart';

const String _kHotel = 'HOTEL';
const String _kFlight = 'FLIGHT';
const String _kTour = 'TOUR';
const String _kCarRental = 'CARRENTAL';
const String _kInsurance = 'INSURANCE';

enum ServiceCardType {
  hotel,
  flight,
  tour,
  carRental,
  insurance,
}

class OtaReservationSuccessBloc extends Bloc<OtaReservationSuccessViewModel> {
  @override
  OtaReservationSuccessViewModel initDefaultValue() {
    return OtaReservationSuccessViewModel(
      otaReservationDetailModel: OtaReservationDetailModel(
        id: '',
      ),
      otaResrvationServiceCardViewModel: [],
    );
  }

  loadArgumenrDetail({
    required ServiceCardType serviceCardType,
    required List<ServiceViewModel> serviceCardList,
    required OtaReservationSuccessArgumentModel argumentModel,
  }) {
    _loadLandingServiceCardList(
      serviceCardType: serviceCardType,
      serviceCardList: serviceCardList,
    );
    _loadReservationSuccessDetail(argumentModel);
    emit(state);
  }

  _loadLandingServiceCardList({
    required ServiceCardType serviceCardType,
    required List<ServiceViewModel> serviceCardList,
  }) {
    final String serviceCards =
        AppConfig().configModel.paymentConfirmationRecommendations;
    final List<String> serviceList = serviceCards.split(',');

    String serviceType = _getServiceType(serviceCardType);
    for (var serviceCard in serviceCardList) {
      if (serviceCard.service != serviceType &&
          serviceList.contains(serviceCard.service)) {
        OtaResrvationServiceCardViewModel serviceCardViewModel =
            OtaResrvationServiceCardViewModel(
          serviceText: serviceCard.serviceText,
          title: serviceCard.title,
          description: serviceCard.description,
          imageUrl: serviceCard.imageUrl,
          largeImageUrl: serviceCard.largeImageUrl,
          serviceBackgroundUrl: serviceCard.serviceBackgroundUrl,
          service: serviceCard.service,
          deeplinkUrl: serviceCard.deepLinkUrl,
        );

        state.otaResrvationServiceCardViewModel.add(serviceCardViewModel);
      }
    }
  }

  _loadReservationSuccessDetail(
      OtaReservationSuccessArgumentModel argumentModel) {
    state.otaReservationDetailModel.id = argumentModel.id;
    state.otaReservationDetailModel.imageUrl = argumentModel.imageUrl ?? '';
    state.otaReservationDetailModel.providerName =
        argumentModel.providerName ?? '';
    state.otaReservationDetailModel.packageName =
        argumentModel.packageName ?? '';
    state.otaReservationDetailModel.highlights = argumentModel.highlights ?? [];
    state.otaReservationDetailModel.tourOrTicketsType =
        argumentModel.tourOrTicketsType ?? [];
    state.otaReservationDetailModel.bookingDate =
        argumentModel.bookingDate ?? DateTime.now();
    state.otaReservationDetailModel.noOfDays = argumentModel.noOfDays ?? 0;
    state.otaReservationDetailModel.activityDuration =
        argumentModel.activityDuration ?? '';
    state.otaReservationDetailModel.adultCount = argumentModel.adultCount ?? 0;
    state.otaReservationDetailModel.childCount = argumentModel.childCount ?? 0;
    state.otaReservationDetailModel.referenceId = argumentModel.referenceId;
  }
}

String _getServiceType(ServiceCardType serviceCardType) {
  switch (serviceCardType) {
    case ServiceCardType.hotel:
      return _kHotel;
    case ServiceCardType.flight:
      return _kFlight;
    case ServiceCardType.tour:
      return _kTour;
    case ServiceCardType.carRental:
      return _kCarRental;
    case ServiceCardType.insurance:
      return _kInsurance;
    default:
      return "";
  }
}
