import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_argument_model.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_model_domain.dart';
import 'package:ota/domain/car_rental/car_payment/repositories/car_payment_repository_impl.dart';
import 'package:ota/domain/car_rental/car_payment/usecases/car_payment_use_cases.dart';

import '../../../../mocks/fixture_reader.dart';

class CarPaymentUsecase implements CarPaymentRepositoryImpl {
  @override
  CarPaymentRemoteDataSource? carPaymentRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, CarPaymentDomainModelData>> getCarPaymentData(
      CarPaymentDomainArgumentModel argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("car_payment/car_payment.json"));
    CarPaymentDomainModelData sort = CarPaymentDomainModelData.fromMap(map);
    return Right(sort);
  }

  @override
  void mockDynamicPlaylistPageData(
      {CarPaymentRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    // TODO: implement mockDynamicPlaylistPageData
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car Payment case group", () {
    test('Car Payment case', () async {
      CarPaymentUseCasesImpl();
      CarPaymentUsecase carPaymentUsecase = CarPaymentUsecase();
      CarPaymentDomainArgumentModel argumentModel =
          CarPaymentDomainArgumentModel(
              rateKey: "",
              refCode: "",
              totalPrice: 2,
              bookingUrn: "",
              additionalNeedsText: "");

      carPaymentUsecase.getCarPaymentData(argumentModel);
    });
  });
}
