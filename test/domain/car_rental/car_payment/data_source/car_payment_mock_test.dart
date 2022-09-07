import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_argument_model.dart';
import 'package:ota/domain/car_rental/car_payment/repositories/car_payment_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/car_payment_impl_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList = MockCarPaymentStatusGraphQl();
  CarPaymentDomainArgumentModel argumentModel = CarPaymentDomainArgumentModel(
      rateKey: "",
      refCode: "",
      totalPrice: 2,
      bookingUrn: "",
      additionalNeedsText: "");

  CarPaymentRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  CarPaymentRepository carPaymentRepository = CarPaymentRepositoryImpl(
    internetInfo: InternetSuccessMock(),
    remoteDataSource: CarPaymentRemoteDataSourceImpl(),
  );

  test("car  Payment Data Source", () {
    CarPaymentRemoteDataSource carPaymentRemoteDataSource =
        CarPaymentRemoteDataSourceImpl();

    CarPaymentRemoteDataSourceImpl.setMock(graphQlResponsePlayList);

    carPaymentRemoteDataSource.getCarPaymentData(argumentModel);
  });
  test(
      'car  Payment  Repository '
      'When calling get car  Payment data '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await carPaymentRepository.getCarPaymentData(argumentModel);

    expect(consentResult.isRight, true);
  });
}
