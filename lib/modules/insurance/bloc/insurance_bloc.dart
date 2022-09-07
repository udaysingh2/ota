import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';
import 'package:ota/domain/insurance/usecases/insurance_usecases.dart';
import 'package:ota/modules/insurance/view_model/insurance_view_model.dart';

const String kErrorCode1899 = '1899';
const String kErrorCode1999 = '1999';
const String kSuccessCode = '1000';
const String kServiceAll = "ALL";
int _kPageSize = 20;

class InsuranceBloc extends Bloc<InsuranceViewModel> {
  InsuranceUseCases insuranceUseCasesImpl = InsuranceUseCasesImpl();

  @override
  InsuranceViewModel initDefaultValue() {
    return InsuranceViewModel(pageState: InsuranceViewModelState.initial);
  }

  bool get showCachedData =>
      state.pageState == InsuranceViewModelState.failureNetwork ||
      state.pageState == InsuranceViewModelState.failure1899 ||
      state.pageState == InsuranceViewModelState.failure1999 ||
      state.pageState == InsuranceViewModelState.failure;

  Future<void> getInsuranceData({
    bool refreshData = false,
    bool isRefresh = false,
    int pageNumber = 1,
    String? serviceType,
  }) async {
    if (refreshData) {
      state.pageState = InsuranceViewModelState.pullDownLoading;
      emit(state);
    } else if (!isRefresh && pageNumber == 1) {
      state.pageState = InsuranceViewModelState.loading;
      emit(state);
    }
    String serviceTypeTemp = serviceType ?? kServiceAll;
    InsuranceArgumentDomain insuranceArgumentDomain = InsuranceArgumentDomain(
        offset: (pageNumber - 1) * _kPageSize,
        limit: _kPageSize,
        recommendedServices: serviceTypeTemp);
    Either<Failure, InsuranceModelDomain> result = (await insuranceUseCasesImpl
        .getInsuranceData(insuranceArgumentDomain))!;

    if (result.isRight) {
      InsuranceModelDomain? data = result.right;
      String? statusCode = data.getInsurance?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.pageState = InsuranceViewModelState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.pageState = InsuranceViewModelState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        if (data.getInsurance != null &&
            data.getInsurance!.data != null &&
            data.getInsurance!.data!.insurances != null &&
            data.getInsurance!.data!.insurances!.isNotEmpty) {
          InsuranceModelData model =
              InsuranceModelData.fromData(data.getInsurance!.data!);
          List.generate(model.insurances!.length, (index) {
            _updateUrlStatus(model.insurances!.elementAt(index).popup!, index);
          });
          if (state.data?.insurances != null &&
              state.data!.insurances!.isNotEmpty &&
              refreshData) {
            state.data?.insurances!.clear();
            state.data?.insurances!.addAll(model.insurances!);
            state.pageState = InsuranceViewModelState.success;
            emit(state);
          } else if (state.data?.insurances != null &&
              state.data!.insurances!.isNotEmpty) {
            state.data?.insurances!.addAll(model.insurances!);
            state.pageState = InsuranceViewModelState.success;
            emit(state);
          } else {
            emit(InsuranceViewModel(
              data: model,
              pageState: InsuranceViewModelState.success,
            ));
          }
        } else {
          state.pageState = InsuranceViewModelState.failure;
          emit(state);
        }
      } else {
        state.pageState = InsuranceViewModelState.failure;
        emit(state);
      }
    } else if (result.left is InternetFailure) {
      if (state.pageState == InsuranceViewModelState.pullDownLoading) {
        state.pageState = InsuranceViewModelState.pullDownLoadingFailureNetwork;
        emit(state);
      } else {
        state.pageState = InsuranceViewModelState.failureNetwork;
        emit(state);
      }
    } else {
      state.pageState = InsuranceViewModelState.failure;
      emit(state);
    }
  }

  _updateUrlStatus(InsurancePopup popup, index) async {
    try {
      final response = await http.get(Uri.parse(popup.actionUrl!),
          headers: {"User-Agent": "Mozilla/4.0"});
      if (response.statusCode < HttpStatus.badRequest) {
        popup.urlStatus = true;
      } else {
        popup.urlStatus = false;
      }
    } catch (exception) {
      popup.urlStatus = false;
    }
  }
}
