import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/hotel_payment_main_view_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';

void main() {
  HotelPaymentMainBloc bloc = HotelPaymentMainBloc();
  // HotelConfirmBookingUseCases successMock =
  //     HotelConfirmBookingUseCasesImplSuccessMock();
  // HotelConfirmBookingUseCases nullMock =
  //     HotelConfirmBookingUseCasesImplNullMock();

  test('For Hotel payment main view Bloc class ==> initDefaultValue()', () {
    bloc.initDefaultValue();
  });

  // test('For Hotel payment main view Bloc class ==> loadFromArgument()',
  //     () async {
  //   await bloc.loadFromArgument(argumentModel);
  //
  //   expect(bloc.state.state, HotelPaymentMainViewModelState.failure);
  // });

  // test('For Hotel payment main view Bloc class ==> loadFromArgument() Success',
  //     () async {
  //   await bloc.loadFromArgument(argumentModel);
  //
  //   Either<Failure, BookingConfirmationData>? result = (await successMock
  //       .getHotelConfirmBooking(argumentModel.mapToDomainArgument()));
  //
  //   expect(result?.isRight, true);
  //   expect(bloc.state.state, HotelPaymentMainViewModelState.failure);
  // });

  // test('For Hotel payment main view Bloc class ==> loadFromArgument() Null',
  //     () async {
  //   await bloc.loadFromArgument(argumentModel);
  //
  //   Either<Failure, BookingConfirmationData>? result = (await nullMock
  //       .getHotelConfirmBooking(argumentModel.mapToDomainArgument()));
  //
  //   expect(result?.isRight, true);
  //   expect(bloc.state.state, HotelPaymentMainViewModelState.failure);
  //   expect(result?.right.data == null, true);
  // });
}

HotelPaymentMainArgumentModel argumentModel = HotelPaymentMainArgumentModel(
  lastName: '',
  firstGuestName: '',
  roomCode: '',
  totalCost: '10.0',
  membershipId: '',
  bookingUrn: '',
  otaCountDownController: OtaCountDownController(durationInSecond: 1),
  secondGuestName: '',
  addonsModels: [],
  additionalNeedsText: '',
  firstName: '',
  freefoodDelivery: true,
  hotelId: '',
);
