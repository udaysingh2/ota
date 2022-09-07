import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_payment_promo_error_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_payment_review_parameters.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart'
    as payment_initiate_v2;
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/usecases/payment_status_usecases.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:ota/modules/payment_method/view_model/payment_status_view_model.dart';

const int _kRetriesAfterExpiry = 3;

class PaymentMethodStatusViewBloc extends Bloc<PaymentMethodStatusViewModel> {
  PaymentStatusUseCasesImpl paymentStatusUseCasesImpl =
      PaymentStatusUseCasesImpl();

  @override
  PaymentMethodStatusViewModel initDefaultValue() {
    return PaymentMethodStatusViewModel(
        pageState: PaymentStatusViewPageState.initial,
        retriesAfterExpiery: _kRetriesAfterExpiry);
  }

  Future<void> getNewBookingUrn(PaymentMethodInitiateArgument? argument) async {
    if (argument == null) {
      emit(PaymentMethodStatusViewModel(
          pageState: PaymentStatusViewPageState.failure));
      return;
    }

    await mapNewBookingUrnData(argument);
  }

  Future<void> mapNewBookingUrnData(
      PaymentMethodInitiateArgument argument) async {
    if (argument.screenComingFrom == ScreenToPayment.carRental) {
      Either<Failure, PaymentNewCarBookingUrnModelDomain?>? result =
          await paymentStatusUseCasesImpl
              .getNewCarBookingUrn(argument.newbookingUrn);
      if (result?.isRight ?? false) {
        PaymentNewCarBookingUrnModelDomain? data = result!.right;
        String? bookingUrn = data?.generateNewBookingUrn?.data?.newBookingUrn;
        _handleNewBookingUrn(bookingUrn, argument);
      } else if (result?.left is InternetFailure) {
        emit(PaymentMethodStatusViewModel(
            pageState: PaymentStatusViewPageState.internetFailure));
      } else {
        emit(PaymentMethodStatusViewModel(
            pageState: PaymentStatusViewPageState.failure));
      }
    } else {
      Either<Failure, PaymentNewBookingUrnModelDomain?>? result =
          await paymentStatusUseCasesImpl
              .getNewBookingUrn(argument.newbookingUrn);
      if (result?.isRight ?? false) {
        PaymentNewBookingUrnModelDomain? data = result!.right;
        String? bookingUrn = data?.generateNewBookingUrn?.data?.newBookingUrn;
        _handleNewBookingUrn(bookingUrn, argument);
      } else if (result?.left is InternetFailure) {
        emit(PaymentMethodStatusViewModel(
            pageState: PaymentStatusViewPageState.internetFailure));
      } else {
        emit(PaymentMethodStatusViewModel(
            pageState: PaymentStatusViewPageState.failure));
      }
    }
  }

  _handleNewBookingUrn(
      String? bookingUrn, PaymentMethodInitiateArgument argument) {
    if (bookingUrn != null) {
      argument.bookingUrn = bookingUrn;
      argument.newbookingUrn = '';
      getInitialPaymentV2(argument, DateTime.now());
    } else {
      emit(PaymentMethodStatusViewModel(
          pageState: PaymentStatusViewPageState.failure));
    }
  }

  Future<void> getInitialPaymentV2(
      PaymentMethodInitiateArgument? argument, DateTime date) async {
    //Set retires for polling
    state.retriesAfterExpiery = _kRetriesAfterExpiry;
    if (argument == null) {
      emit(PaymentMethodStatusViewModel(
          pageState: PaymentStatusViewPageState.failure));
      return;
    }

    await mapPaymentInitiateDataV2(paymentStatusUseCasesImpl, argument, date);
  }

  Future<void> mapPaymentInitiateDataV2(
      PaymentStatusUseCasesImpl paymentStatusUseCasesImpl,
      PaymentMethodInitiateArgument argument,
      DateTime date) async {
    Either<Failure, payment_initiate_v2.PaymentInitiateNewModelDomain?>?
        result = await paymentStatusUseCasesImpl.getPaymentInitiateV2(
            argument.toPaymentInitiateArgumentModelDomain());

    if (result?.isRight ?? false) {
      final payment_initiate_v2.InitiatePaymentV2? initiatePayment =
          result!.right?.initiatePaymentV2;
      final String? statusCode = initiatePayment?.status?.code;
      CarPaymentPromoErrorFirebase.errorCode =
          HotelPaymentReviewFirebase.errorCode = statusCode ?? '';
      CarPaymentPromoErrorFirebase.errorDescription = HotelPaymentReviewFirebase
          .errorDescription = initiatePayment?.status?.description;
      if (statusCode == kSuccessCode) {
        String? bookingUrn = initiatePayment?.data?.bookingUrn;
        if (bookingUrn != null && bookingUrn.isNotEmpty) {
          getPaymentStatus(bookingUrn, date);
        } else {
          _emitFailure();
        }
      } else if (statusCode == kErrorCode3000) {
        emit(PaymentMethodStatusViewModel(
            pageState: PaymentStatusViewPageState.failurePromo3000));
      } else {
        _emitFailure();
      }
    } else if (result?.left is InternetFailure) {
      emit(PaymentMethodStatusViewModel(
          pageState: PaymentStatusViewPageState.internetFailure));
    } else {
      _emitFailure();
    }
  }

  Future<void> getPaymentStatus(String? bookingUrn, DateTime date) async {
    if (bookingUrn == null) {
      emit(PaymentMethodStatusViewModel(
          pageState: PaymentStatusViewPageState.failure));
      return;
    }

    mapPaymentStatusData(paymentStatusUseCasesImpl, bookingUrn, date);
  }

  bool isDeepLinkFound = false;

  Future<void> mapPaymentStatusData(
      PaymentStatusUseCasesImpl paymentStatusUseCasesImpl,
      String bookingUrn,
      DateTime date) async {
    Either<Failure, PaymentStatusModelDomain?>? result =
        await paymentStatusUseCasesImpl.getPaymentStatus(bookingUrn);

    if (result?.isRight ?? false) {
      PaymentStatusModelDomain? data = result!.right;
      PaymentStatusData? paymentStatusData = data?.paymentStatus?.data;

      if (paymentStatusData != null) {
        if (paymentStatusData.paymentStatus ==
            PaymentStatusState.success.value) {
          emit(PaymentMethodStatusViewModel(
              pageState: PaymentStatusViewPageState.success,
              data: PaymentMethodStatusDataModel.mapFromResponse(
                  paymentStatusData, bookingUrn)));
        } else if (paymentStatusData.deeplinkUrl != null && !isDeepLinkFound) {
          if (ifTimeOutNotHappened(date)) {
            await Future.delayed(
                Duration(
                    seconds: AppConfig()
                        .configModel
                        .paymentStatusTimeIntervalInSec), () {
              getPaymentStatus(bookingUrn, date);
              return;
            });
          }
          emit(PaymentMethodStatusViewModel(
              pageState: PaymentStatusViewPageState.deeplinkFound,
              data: PaymentMethodStatusDataModel.mapFromResponse(
                  paymentStatusData, bookingUrn)));
        } else if (paymentStatusData.paymentStatus ==
            PaymentStatusState.failed.value) {
          emit(PaymentMethodStatusViewModel(
              pageState: PaymentStatusViewPageState.failure));
        } else {
          if (ifTimeOutNotHappened(date)) {
            await Future.delayed(
                Duration(
                    seconds: AppConfig()
                        .configModel
                        .paymentStatusTimeIntervalInSec), () {
              getPaymentStatus(bookingUrn, date);
              return;
            });
          } else {
            emit(PaymentMethodStatusViewModel(
                pageState: PaymentStatusViewPageState.failure));
          }
        }
      } else {
        if (ifTimeOutNotHappened(date)) {
          await Future.delayed(
              Duration(
                  seconds: AppConfig()
                      .configModel
                      .paymentStatusTimeIntervalInSec), () {
            getPaymentStatus(bookingUrn, date);
            return;
          });
        } else {
          emit(PaymentMethodStatusViewModel(
              pageState: PaymentStatusViewPageState.failure));
        }
      }
    } else if (result?.left is InternetFailure) {
      emit(PaymentMethodStatusViewModel(
          pageState: PaymentStatusViewPageState.internetFailure));
    } else {
      if (ifTimeOutNotHappened(date)) {
        await Future.delayed(
            Duration(
                seconds: AppConfig()
                    .configModel
                    .paymentStatusTimeIntervalInSec), () {
          getPaymentStatus(bookingUrn, date);
          return;
        });
      } else {
        emit(PaymentMethodStatusViewModel(
            pageState: PaymentStatusViewPageState.failure));
      }
    }
  }

  bool ifTimeOutNotHappened(DateTime date) {
    //Check if time not expired?
    if (DateTime.now().difference(date).inMinutes <
        AppConfig().configModel.paymentWaitingTimesInMin) {
      return true;
    }
    //Time is expired but lets make double check for status using retries?
    if (state.retriesAfterExpiery > 0) {
      state.retriesAfterExpiery--;
      //Time is expired but still we can retry to make sure if we get the
      // right response. even after the time out
      return true;
    }
    //Time is expired also retries also expired.
    return false;
  }

  void setDeepLinkAsFound() {
    isDeepLinkFound = true;
  }

  bool get isFailure3000 =>
      state.pageState == PaymentStatusViewPageState.failurePromo3000;

  void _emitFailure() {
    emit(PaymentMethodStatusViewModel(
        pageState: PaymentStatusViewPageState.failure));
  }
}
