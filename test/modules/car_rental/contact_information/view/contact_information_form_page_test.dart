import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/contact_information/models/update_customer_details_model.dart';
import 'package:ota/domain/car_rental/contact_information/use_cases/update_customer_use_cases.dart';
import 'package:ota/modules/car_rental/contact_information/bloc/contact_information_bloc.dart';
import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';
import '../bloc/mocks/contact_information_use_cases_mock.dart';

const _kOtaRadioButton = "SaveCheckbox";
const _kContactSubmit = "ContactSubmit";
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Contact information page test", () {
    testWidgets('Car Contact information Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
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
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.carContactInformation,
                      arguments: ContactInformationArgumentModel(
                        initialContactInformationArgumentData:
                            ContactInformationArgumentData(
                          firstName: 'FirstName',
                          email: 'name@email.com',
                          phoneNumber: '01234567',
                          lastName: 'lastname',
                        ),
                        onOkClicked: (ContactInformationArgumentData
                            updatedContactInformationArgumentData) {},
                      )));
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pump();
        await tester.pumpAndSettle();
        expect(find.byKey(const Key(_kOtaRadioButton)), findsOneWidget);
        await tester.tap(find.byKey(const Key(_kOtaRadioButton)));
        await tester.pump();

        expect(find.byKey(const Key(_kContactSubmit)), findsOneWidget);
        await tester.tap(find.byKey(const Key(_kContactSubmit)));
        await tester.pump();
      });
    });
  });

  group("Contact Information Bloc", () {
    ContactInformationBloc bloc = ContactInformationBloc();

    test('For ContactInformationBloc class ==> initDefaultValue()', () {
      final actual = bloc.initDefaultValue();

      expect(actual.submitCustomerDetailsState,
          SubmitCustomerDetailsState.initial);
    });

    test('For ContactInformationBloc class ==> onOkClicked()', () {
      bloc.state.initialContactInformationArgumentData = getContactData();

      bloc.onOkClicked();

      expect(bloc.state.submitCustomerDetailsState,
          SubmitCustomerDetailsState.initial);
    });

    test('For ContactInformationBloc class ==> isFormValid()', () {
      ///If firstName is Empty
      bloc.state.initialContactInformationArgumentData.firstName = '';
      final actual = bloc.isFormValid;
      expect(!actual, true);

      ///If firstName is Empty
      bloc.state.initialContactInformationArgumentData.firstName = 'test';
      final actual1 = bloc.isFormValid;
      expect(actual1, true);

      ///If all param is valid
      bloc.state.initialContactInformationArgumentData.firstName = 'test1';
      bloc.state.initialContactInformationArgumentData.lastName = 'test2';
      final actual2 = bloc.isFormValid;
      expect(actual2, true);
    });

    group('For ContactInformationBloc class ==> checkValidation()', () {
      test('For ContactInformationBloc class ==> firstName is Empty', () {
        ///If firstName is Empty
        bloc.state.initialContactInformationArgumentData.firstName = '';
        bloc.checkValidation();
        expect(bloc.state.firstNameBloc?.state.otaTextInputState,
            OtaTextInputState.error);

        ///If firstName is valid
        bloc.state.initialContactInformationArgumentData.firstName = 'test';
        bloc.checkValidation();
        expect(bloc.state.firstNameBloc?.state.otaTextInputState,
            OtaTextInputState.valid);
      });

      test('For ContactInformationBloc class ==> lastName is Empty', () {
        ///If lastName is Empty
        bloc.state.initialContactInformationArgumentData.firstName = 'test';
        bloc.state.initialContactInformationArgumentData.lastName = '';
        bloc.checkValidation;
        expect(bloc.state.lastNameBloc?.state.otaTextInputState,
            OtaTextInputState.valid);

        ///If lastName is valid
        bloc.state.initialContactInformationArgumentData.firstName = 'test';
        bloc.state.initialContactInformationArgumentData.lastName = 'test';
        bloc.checkValidation;
        expect(bloc.state.lastNameBloc?.state.otaTextInputState,
            OtaTextInputState.valid);
      });
    });

    test('For ContactInformationBloc class ==> updateTextState()', () {
      bloc.updateTextState();

      expect(bloc.state.submitCustomerDetailsState,
          SubmitCustomerDetailsState.initial);
    });

    test('For ContactInformationBloc class ==> mapFromArgument()', () {
      bloc.mapFromArgument(getArgs());

      expect(bloc.state.submitCustomerDetailsState,
          SubmitCustomerDetailsState.initial);
    });

    group('For ContactInformationBloc() class ==> submitApiCall', () {
      UpdateCustomerUseCases successMock = ContactInformationAllSuccessMock();
      UpdateCustomerUseCases statusNot1000Mock =
          ContactInformationStatusNot1000Mock();
      UpdateCustomerUseCases failureMock = ContactInformationFailureMock();

      test('For submitApiCall() ==>If Status code is 1000 then', () async {
        bloc.contactUseCases = successMock;
        bloc.submitApiCall(getContactData());

        Either<Failure, UpdateCustomerData>? result =
            await successMock.updateCustomerData(getContactData());

        expect(result?.isRight, true);
        expect(bloc.state.submitCustomerDetailsState,
            SubmitCustomerDetailsState.success);
      });

      test('For submitApiCall() ==> If Status code is Not 1000 then', () async {
        bloc.contactUseCases = statusNot1000Mock;
        bloc.submitApiCall(getContactData());

        Either<Failure, UpdateCustomerData>? result =
            await statusNot1000Mock.updateCustomerData(getContactData());

        expect(result?.isRight, true);
        expect(bloc.state.submitCustomerDetailsState,
            SubmitCustomerDetailsState.failure);
      });

      test('For submitApiCall() ==> If Failure', () async {
        bloc.contactUseCases = failureMock;
        bloc.submitApiCall(getContactData());

        Either<Failure, UpdateCustomerData>? result =
            await failureMock.updateCustomerData(getContactData());

        expect(result?.isLeft, true);
      });
    });
  });
}

ContactInformationArgumentModel getArgs() {
  return ContactInformationArgumentModel(
    initialContactInformationArgumentData: getContactData(),
    onOkClicked: (ContactInformationArgumentData
        updatedContactInformationArgumentData) {},
  );
}

ContactInformationArgumentData getContactData() =>
    ContactInformationArgumentData(
      firstName: 'firstName',
      email: 'email',
      phoneNumber: 'phoneNumber',
      contactInformationSelected: true,
      lastName: 'test',
      starRating: '5',
    );
