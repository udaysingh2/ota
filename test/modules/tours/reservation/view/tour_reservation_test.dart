import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_mock.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';
import 'package:ota/domain/tours/review_reservation/data_sources/pickup_point_remote_data_source.dart';
import 'package:ota/domain/tours/review_reservation/data_sources/pickup_point_remote_data_source_mock.dart';
import 'package:ota/domain/tours/review_reservation/data_sources/tours_review_reservation_remote_data_source.dart';
import 'package:ota/domain/tours/review_reservation/repositories/pickup_point_repository_impl.dart';
import 'package:ota/domain/tours/review_reservation/repositories/tours_review_reservation_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/tours/reservation/bloc/tours_review_reservation_bloc.dart';
import 'package:ota/modules/tours/reservation/view/tour_reservation.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_argument.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_model.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  TourReviewReservationModel args = _getReservationDetail();
  group("TourReservation Screen", () {
    testWidgets('TourReservation Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
        PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
        CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
        CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('TourReservation Screen init', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
        PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
        CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
        CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
        ToursReviewReservationRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourReviewReservationRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: jsonDecode(_responseMock)));
        TourReviewReservationBloc bloc = TourReviewReservationBloc();
        bloc.initDetails(args.reviewReservationData);
        bloc.initiateTourBooking(argument);
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('TourReservation Screen internet failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
        PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
        CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
        CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
        ToursReviewReservationRepositoryImpl.setMockInternet(
            InternetFailureMock());
        TourReviewReservationRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: jsonDecode(_responseMock)));
        TourReviewReservationBloc bloc = TourReviewReservationBloc();
        bloc.initiateTourBooking(argument);
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('TourReservation Screen 1899 failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
        PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
        CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
        CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
        ToursReviewReservationRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourReviewReservationRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: jsonDecode(_failResponseMock)));
        TourReviewReservationBloc bloc = TourReviewReservationBloc();
        bloc.initiateTourBooking(argument);
        bloc.state.screenState = TourReviewReservationScreenState.failure;
        TourReservationScreen screen = const TourReservationScreen();
        Widget widget = ProviderInitializer(
          MaterialApp(
            navigatorKey: GlobalKeys.navigatorKey,
            routes: AppRoutes.getRoutes(),
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
              Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode),
            ],
            localizationsDelegates: const [
              Localization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              return supportedLocales.elementAt(0);
            },
            home: Scaffold(
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screen,
                        settings: RouteSettings(arguments: args)),
                  ),
                );
              }),
            ),
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await tester.pump();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('TourReservation Screen not found failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
        PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
        CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
        CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
        ToursReviewReservationRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourReviewReservationRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: jsonDecode(_notFoundResponseMock)));
        TourReviewReservationBloc bloc = TourReviewReservationBloc();
        bloc.initiateTourBooking(argument);
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('TourReservation Screen minimum pax required failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
        PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
        CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
        CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
        ToursReviewReservationRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: jsonDecode(_minPaxRequiredResponseMock)));
        TourReviewReservationBloc bloc = TourReviewReservationBloc();
        bloc.initiateTourBooking(argument);
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
}

final TourReviewReservationArgument argument = TourReviewReservationArgument(
    bookingDate: DateTime.now(),
    serviceType: 'SIC',
    startTime: '10:00',
    countryId: 'MA05110001',
    refCode: 'CL213',
    rateKey: 'TUEyMTExMDAwMDQw',
    zoneId: 'MA21110028',
    totalPrice: 1211.5,
    cityId: 'MA05110041',
    serviceId: 'MA21110305',
    timeOfDay: 'AM',
    currency: 'TBH',
    tourId: 'MA2111000168',
    childAge: [2, 3],
    packageReservationArgument: PackageReservationArgument(
        children: 1,
        adults: 1,
        adultPaxId: 'MA05110001',
        adultPrice: 1000,
        name: 'SIC',
        childPaxId: 'MA05110001',
        childPrice: 1000));

TourReviewReservationModel _getReservationDetail() {
  return TourReviewReservationModel(
    reviewReservationData: TourReviewReservationViewModel(
      bookingUrn: "TR220117-AA-0006",
      tourName: "Bangkok Hop on Hop off(Wangthong Garden)",
      tourId: "MA2111000115",
      totalPrice: 1200.00,
      lastPrice: 1200.00,
      adultCount: 2,
      tourImage:
          "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/place-profile-place-name-bangkok-hop-on-hop-off-ma2111000115-general1.jpg",
      promotionData: [
        OtaFreeFoodPromotionModel(
            headerText: "Free food",
            subHeaderText: "Free food",
            headerIcon:
                "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/place-profile-place-name-bangkok-hop-on-hop-off-ma2111000115-general1.jpg",
            deepLinkUrl: "www.google.com",
            promotionCode: "Free food",
            line1: "Free food")
      ],
      tourPackage: TourPackageViewModel(
          rateKey: 'tourTime',
          childPaxId: 'string',
          serviceId: 'string',
          adultPaxId: 'string',
          refCode: 'string',
          adultPrice: 33,
          packageName: 'string',
          requireInfo:
              TourRequireInfoViewModel(allName: true, passportCountry: true)),
      childCount: 1,
    ),
    lastPrice: 1200.00,
    childCount: 1,
    adultCount: 1,
    argument: TourReviewReservationArgument(
        tourId: "123",
        countryId: '1',
        cityId: '7',
        bookingDate: DateTime.now(),
        currency: 'INR',
        totalPrice: 1200.00,
        rateKey: 'eeee',
        serviceId: 'ee',
        serviceType: 'eer',
        childAge: [3, 6],
        packageReservationArgument: PackageReservationArgument(
            childPrice: 1200.00,
            name: 'Bangkok Hop on Hop off',
            childPaxId: 'string',
            adultPrice: 1200.00,
            adultPaxId: 'string',
            children: 1,
            adults: 1),
        zoneId: 'string',
        refCode: 'string',
        startTime: "10:00",
        timeOfDay: "AM"),
  );
}

var _responseMock = '''
{
	"getTourBookingInitiate": {
		"data": {
			"bookingUrn": "TR220103-AA-0024",
			"tourName": "Dog Cafe 112(April Tour)",
			"tourImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
			"promotionList": [{

				"productType": "ACTIVITY",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"tourDetails": {
				"id": "MA2111000068",
				"name": "Dog Cafe 112(April Tour)",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
				"category": "Nightlife",
				"location": "Larn Luang,Cha-am, Phetchaburi",
				"information": {
					"description": "Welcome to Dog Cafe 112",
					"conditions": "",
					"howToUse": "",
					"providerName": "April Tour",
					"openTime": "08:00",
					"closeTime": "18:00"
				},
				"packages": [{
					"name": "Dog Cafe 112 SIC",
					"options": "Dog Cafe 112 SIC",
					"inclusions": {
						"highlights": [{
								"key": "tourTime",
								"value": "Full day tour starts at 08:00 AM"
							},
							{
								"key": "tourType",
								"value": "Group tour"
							},
							{
								"key": "guideLanguage",
								"value": "English-speaking tour guide"
							},
							{
								"key": "isNonRefund",
								"value": null
							}
						],
						"all": ""
					},
					"exclusions": "",
					"schedule": "",
					"meetingPoint": "",
					"conditions": "",
					"cancellationPolicy": "",
					"shuttle": "",
					"adultPrice": 200,
					"childPrice": 100,
					"adultPaxId": "MA01010001",
					"childPaxId": "MA01010002",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					},
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "MA21110100",
					"rateKey": "TUEyMTEyMDAwMDAz",
					"availableSeats": 200,
					"minimumSeats": 2,
					"serviceType": "SIC",
					"durationText": "",
					"duration": "0",
					"zoneId": "MA21110009",
					"requireInfo": {
						"weight": false,
						"allName": false,
						"guestName": false,
						"passportId": false,
						"dateOfBirth": false,
						"passportCountry": false,
						"passportValidDate": false,
						"passportCountryIssue": false
					}
				}]
			}
		},
		"status": {
			"code": "1000",
			"header": "Success"
		}
	}
}
	''';

var _failResponseMock = '''
{
	"getTourBookingInitiate": {
		"data": {
			"bookingUrn": "TR220103-AA-0024",
			"tourName": "Dog Cafe 112(April Tour)",
			"tourImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
			"promotionList": [{

				"productType": "ACTIVITY",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"tourDetails": {
				"id": "MA2111000068",
				"name": "Dog Cafe 112(April Tour)",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
				"category": "Nightlife",
				"location": "Larn Luang,Cha-am, Phetchaburi",
				"information": {
					"description": "Welcome to Dog Cafe 112",
					"conditions": "",
					"howToUse": "",
					"providerName": "April Tour",
					"openTime": "08:00",
					"closeTime": "18:00"
				},
				"packages": [{
					"name": "Dog Cafe 112 SIC",
					"options": "Dog Cafe 112 SIC",
					"inclusions": {
						"highlights": [{
								"key": "tourTime",
								"value": "Full day tour starts at 08:00 AM"
							},
							{
								"key": "tourType",
								"value": "Group tour"
							},
							{
								"key": "guideLanguage",
								"value": "English-speaking tour guide"
							},
							{
								"key": "isNonRefund",
								"value": null
							}
						],
						"all": ""
					},
					"exclusions": "",
					"schedule": "",
					"meetingPoint": "",
					"conditions": "",
					"cancellationPolicy": "",
					"shuttle": "",
					"adultPrice": 200,
					"childPrice": 100,
					"adultPaxId": "MA01010001",
					"childPaxId": "MA01010002",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					},
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "MA21110100",
					"rateKey": "TUEyMTEyMDAwMDAz",
					"availableSeats": 200,
					"minimumSeats": 2,
					"serviceType": "SIC",
					"durationText": "",
					"duration": "0",
					"zoneId": "MA21110009",
					"requireInfo": {
						"weight": false,
						"allName": false,
						"guestName": false,
						"passportId": false,
						"dateOfBirth": false,
						"passportCountry": false,
						"passportValidDate": false,
						"passportCountryIssue": false
					}
				}]
			}
		},
		"status": {
			"code": "1899",
			"header": "member_login_failure"
		}
	}
}
	''';

var _notFoundResponseMock = '''
{
	"getTourBookingInitiate": {
		"data": {
			"bookingUrn": "TR220103-AA-0024",
			"tourName": "Dog Cafe 112(April Tour)",
			"tourImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
			"promotionList": [{

				"productType": "ACTIVITY",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"tourDetails": {
				"id": "MA2111000068",
				"name": "Dog Cafe 112(April Tour)",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
				"category": "Nightlife",
				"location": "Larn Luang,Cha-am, Phetchaburi",
				"information": {
					"description": "Welcome to Dog Cafe 112",
					"conditions": "",
					"howToUse": "",
					"providerName": "April Tour",
					"openTime": "08:00",
					"closeTime": "18:00"
				},
				"packages": [{
					"name": "Dog Cafe 112 SIC",
					"options": "Dog Cafe 112 SIC",
					"inclusions": {
						"highlights": [{
								"key": "tourTime",
								"value": "Full day tour starts at 08:00 AM"
							},
							{
								"key": "tourType",
								"value": "Group tour"
							},
							{
								"key": "guideLanguage",
								"value": "English-speaking tour guide"
							},
							{
								"key": "isNonRefund",
								"value": null
							}
						],
						"all": ""
					},
					"exclusions": "",
					"schedule": "",
					"meetingPoint": "",
					"conditions": "",
					"cancellationPolicy": "",
					"shuttle": "",
					"adultPrice": 200,
					"childPrice": 100,
					"adultPaxId": "MA01010001",
					"childPaxId": "MA01010002",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					},
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "MA21110100",
					"rateKey": "TUEyMTEyMDAwMDAz",
					"availableSeats": 200,
					"minimumSeats": 2,
					"serviceType": "SIC",
					"durationText": "",
					"duration": "0",
					"zoneId": "MA21110009",
					"requireInfo": {
						"weight": false,
						"allName": false,
						"guestName": false,
						"passportId": false,
						"dateOfBirth": false,
						"passportCountry": false,
						"passportValidDate": false,
						"passportCountryIssue": false
					}
				}]
			}
		},
		"status": {
			"code": "1899",
			"header": "not_found"
		}
	}
}
	''';

var _minPaxRequiredResponseMock = '''
{
	"getTourBookingInitiate": {
		"data": {
			"bookingUrn": "TR220103-AA-0024",
			"tourName": "Dog Cafe 112(April Tour)",
			"tourImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
			"promotionList": [{

				"productType": "ACTIVITY",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"tourDetails": {
				"id": "MA2111000068",
				"name": "Dog Cafe 112(April Tour)",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
				"category": "Nightlife",
				"location": "Larn Luang,Cha-am, Phetchaburi",
				"information": {
					"description": "Welcome to Dog Cafe 112",
					"conditions": "",
					"howToUse": "",
					"providerName": "April Tour",
					"openTime": "08:00",
					"closeTime": "18:00"
				},
				"packages": [{
					"name": "Dog Cafe 112 SIC",
					"options": "Dog Cafe 112 SIC",
					"inclusions": {
						"highlights": [{
								"key": "tourTime",
								"value": "Full day tour starts at 08:00 AM"
							},
							{
								"key": "tourType",
								"value": "Group tour"
							},
							{
								"key": "guideLanguage",
								"value": "English-speaking tour guide"
							},
							{
								"key": "isNonRefund",
								"value": null
							}
						],
						"all": ""
					},
					"exclusions": "",
					"schedule": "",
					"meetingPoint": "",
					"conditions": "",
					"cancellationPolicy": "",
					"shuttle": "",
					"adultPrice": 200,
					"childPrice": 100,
					"adultPaxId": "MA01010001",
					"childPaxId": "MA01010002",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					},
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "MA21110100",
					"rateKey": "TUEyMTEyMDAwMDAz",
					"availableSeats": 200,
					"minimumSeats": 2,
					"serviceType": "SIC",
					"durationText": "",
					"duration": "0",
					"zoneId": "MA21110009",
					"requireInfo": {
						"weight": false,
						"allName": false,
						"guestName": false,
						"passportId": false,
						"dateOfBirth": false,
						"passportCountry": false,
						"passportValidDate": false,
						"passportCountryIssue": false
					}
				}]
			}
		},
		"status": {
			"code": "1899",
			"header": "not_found"
		}
	}
}
	''';
