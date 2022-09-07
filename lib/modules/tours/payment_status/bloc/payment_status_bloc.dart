import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_payment_error_payment_parameters.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/usecases/payment_status_usecases.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:ota/modules/tours/payment_status/view_model/payment_status_view_model.dart';

class PaymentStatusBloc extends Bloc<PaymentStatusViewModel> {
  @override
  PaymentStatusViewModel initDefaultValue() {
    return PaymentStatusViewModel(
        paymentStatusViewState: PaymentStatusViewState.initial);
  }

  Future<void> getNewBookingUrnData(
      PaymentMethodInitiateArgument argument) async {
    PaymentStatusUseCasesImpl paymentStatusUseCasesImpl =
        PaymentStatusUseCasesImpl();
    await _mapNewBookingUrnData(paymentStatusUseCasesImpl, argument);
  }

  Future<void> _mapNewBookingUrnData(
      PaymentStatusUseCasesImpl paymentStatusUseCasesImpl,
      PaymentMethodInitiateArgument argument) async {
    Either<Failure, PaymentNewBookingUrnModelDomain?>? result =
        await paymentStatusUseCasesImpl
            .getNewBookingUrn(argument.newbookingUrn);
    if (result?.isRight ?? false) {
      PaymentNewBookingUrnModelDomain? bookingUrnResult = result!.right;
      String? statusCode =
          bookingUrnResult?.generateNewBookingUrn?.status?.code;
      ActivityPaymentErrorPaymentFirebase.errorCodePayment = statusCode ?? "";
      ActivityPaymentErrorPaymentFirebase.errorDescriptionPayment =
          bookingUrnResult?.generateNewBookingUrn?.status?.description;
      if (statusCode == kSuccessCode) {
        String? bookingUrn =
            bookingUrnResult?.generateNewBookingUrn?.data?.newBookingUrn;
        if (bookingUrn != null) {
          argument.bookingUrn = bookingUrn;
          argument.newbookingUrn = '';
          getPaymentInitiateDataV2(argument, DateTime.now());
        } else {
          _emitFailure();
        }
      } else {
        _emitFailure();
      }
    } else {
      _emitFailure();
    }
  }

  Future<void> _getPaymentStatusData(String? bookingUrn, DateTime date) async {
    if (bookingUrn == null) {
      _emitFailure();
      return;
    }
    PaymentStatusUseCasesImpl paymentStatusUseCasesImpl =
        PaymentStatusUseCasesImpl();
    await _mapPaymentStatusData(paymentStatusUseCasesImpl, bookingUrn, date);
  }

  bool isDeepLinkFound = false;

  Future<void> _mapPaymentStatusData(
      PaymentStatusUseCasesImpl paymentStatusUseCasesImpl,
      String bookingUrn,
      DateTime date) async {
    Either<Failure, PaymentStatusModelDomain?>? result =
        await paymentStatusUseCasesImpl.getPaymentStatus(bookingUrn);
    if (result?.isRight ?? false) {
      String? statusCode = result!.right?.paymentStatus?.status?.code;
      PaymentStatusData? paymentStatusData = result.right?.paymentStatus?.data;
      ActivityPaymentErrorPaymentFirebase.errorCodePayment = statusCode ?? "";
      ActivityPaymentErrorPaymentFirebase.errorDescriptionPayment =
          result.right?.paymentStatus?.status?.description;
      if (statusCode == kSuccessCode) {
        if (paymentStatusData != null) {
          if (paymentStatusData.paymentStatus ==
              PaymentStatusState.success.value) {
            state.paymentStatusModel = PaymentStatusModel.mapFromResponse(
                paymentStatusData, bookingUrn);
            state.paymentStatusViewState = PaymentStatusViewState.success;
            emit(state);
          } else if (paymentStatusData.deeplinkUrl != null &&
              !isDeepLinkFound) {
            _getPaymentStatusOnPaymentWaitTime(bookingUrn, date);

            state.paymentStatusModel = PaymentStatusModel.mapFromResponse(
                paymentStatusData, bookingUrn);
            state.paymentStatusViewState = PaymentStatusViewState.deeplinkFound;
            emit(state);
          } else if (paymentStatusData.paymentStatus ==
              PaymentStatusState.failed.value) {
            _emitFailure();
          } else {
            _getPaymentStatusOnPaymentWaitTime(bookingUrn, date);
          }
        } else {
          _getPaymentStatusOnPaymentWaitTime(bookingUrn, date);
        }
      } else {
        _emitFailure();
      }
    } else if (result?.left is InternetFailure) {
      state.paymentStatusViewState = PaymentStatusViewState.internetFailure;
      emit(state);
    } else {
      _getPaymentStatusOnPaymentWaitTime(bookingUrn, date);
    }
  }

  void _getPaymentStatusOnPaymentWaitTime(
      String bookingUrn, DateTime paymentInitDateTime) async {
    if (DateTime.now().difference(paymentInitDateTime).inMinutes <
        AppConfig().configModel.paymentWaitingTimesInMin) {
      await Future.delayed(
        Duration(
            seconds: AppConfig().configModel.paymentStatusTimeIntervalInSec),
        () {
          _getPaymentStatusData(bookingUrn, paymentInitDateTime);
          return;
        },
      );
    } else {
      _emitFailure();
    }
  }

  void _emitFailure() {
    state.paymentStatusViewState = PaymentStatusViewState.failure;
    emit(state);
  }

  Future<void> getPaymentInitiateDataV2(
      PaymentMethodInitiateArgument? argument, DateTime date) async {
    if (argument == null) {
      _emitFailure();
      return;
    }
    PaymentStatusUseCasesImpl paymentStatusUseCasesImpl =
        PaymentStatusUseCasesImpl();
    await _mapPaymentInitiateDataV2(paymentStatusUseCasesImpl, argument, date);
  }

  Future<void> _mapPaymentInitiateDataV2(
      PaymentStatusUseCasesImpl paymentStatusUseCasesImpl,
      PaymentMethodInitiateArgument argument,
      DateTime date) async {
    Either<Failure, PaymentInitiateNewModelDomain?>? result =
        await paymentStatusUseCasesImpl.getPaymentInitiateV2(
            argument.toPaymentInitiateArgumentModelDomain());

    if (result?.isRight ?? false) {
      final InitiatePaymentV2? tourTicketinitiatePayment =
          result!.right?.initiatePaymentV2;
      final String? statusCode = tourTicketinitiatePayment?.status?.code;
      ActivityPaymentErrorPaymentFirebase.errorCodePayment = statusCode ?? "";
      ActivityPaymentErrorPaymentFirebase.errorDescriptionPayment =
          tourTicketinitiatePayment?.status?.description;
      if (statusCode == kSuccessCode) {
        String? bookingUrn = tourTicketinitiatePayment?.data?.bookingUrn;
        if (bookingUrn != null && bookingUrn.isNotEmpty) {
          _getPaymentStatusData(bookingUrn, date);
        } else {
          _emitFailure();
        }
      } else if (statusCode == kErrorCode3000) {
        state.paymentStatusViewState = PaymentStatusViewState.failurePromo3000;
        emit(state);
      } else {
        _emitFailure();
      }
    } else {
      _emitFailure();
    }
  }

  void setDeepLinkAsFound() {
    isDeepLinkFound = true;
  }

  bool get isFailure3000 =>
      state.paymentStatusViewState == PaymentStatusViewState.failurePromo3000;

  bool get isFailure =>
      state.paymentStatusViewState == PaymentStatusViewState.failure;

  bool get isSuccess =>
      state.paymentStatusViewState == PaymentStatusViewState.success;

  bool get isDeeplinkFound =>
      state.paymentStatusViewState == PaymentStatusViewState.deeplinkFound;

  bool get isInternetFailure =>
      state.paymentStatusViewState == PaymentStatusViewState.internetFailure;
}
