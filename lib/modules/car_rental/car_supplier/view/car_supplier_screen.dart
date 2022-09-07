import 'package:flutter/material.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_supplier_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/channels/super_app_to_confirm_register_booking.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_update.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_supplier/bloc/car_supplier_bloc.dart';
import 'package:ota/modules/car_rental/car_supplier/view/widgets/car_supplier_card_widget.dart';
import 'package:ota/modules/car_rental/car_supplier/view/widgets/car_supplier_header_widget.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_view_model.dart';
import 'package:provider/provider.dart';

const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";

const _kCarSupplierCardWidgetKey = '_kCarSupplierCardWidgetKey';

class CarSupplierScreen extends StatefulWidget {
  const CarSupplierScreen({Key? key}) : super(key: key);

  @override
  CarSupplierScreenState createState() => CarSupplierScreenState();
}

class CarSupplierScreenState extends State<CarSupplierScreen> {
  final CarSupplierBloc _bloc = CarSupplierBloc();
  List<CarSupplierData> _carSupplierList = [];
  CarSupplierArgumentViewModel? _argument;

  final SuperAppToCarRegisterConfirmBooking
      superAppToCarRegisterConfirmBooking =
      SuperAppToCarRegisterConfirmBooking();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _argument = ModalRoute.of(context)?.settings.arguments
          as CarSupplierArgumentViewModel;
      requestCarSupplierData();
      superAppToCarRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
    _bloc.stream.listen((event) {
      if (_bloc.state.carSupplierViewModelState ==
          CarSupplierViewModelState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  Future<void> requestCarSupplierData() async {
    return _bloc.getCarSupplierData(_argument);
  }

  @override
  Widget build(BuildContext context) {
    _argument = ModalRoute.of(context)?.settings.arguments
        as CarSupplierArgumentViewModel;
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder(
          bloc: _bloc,
          builder: () {
            bool isFailure = (_bloc.state.carSupplierViewModelState ==
                        CarSupplierViewModelState.failure ||
                    _bloc.state.carSupplierViewModelState ==
                        CarSupplierViewModelState.failureNetwork) &&
                _bloc.state.data.isEmpty;
            bool isSuccess = _bloc.state.carSupplierViewModelState ==
                CarSupplierViewModelState.success;
            bool isLoading = _bloc.state.carSupplierViewModelState ==
                CarSupplierViewModelState.loading;
            _carSupplierList = _bloc.state.data;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: kSize16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CarSupplierHeaderWidget(
                      carName: _argument?.carName ?? '',
                      brandName: _argument?.brandName ?? '',
                      craftType: _argument?.craftType ?? '',
                      imageUrl: _argument?.thumbImage,
                      amenitiesList:
                          _getAmenitiesList(_bloc.state.promotionListData),
                    ),
                    const SizedBox(
                      height: kSize16,
                    ),
                    if (isFailure) _failureWidget(),
                    if (isLoading) _loadingWidget(),
                    if (isSuccess) _successWidget(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    superAppToCarRegisterConfirmBooking.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return OtaAppBar(
      isCenterTitle: false,
      titleWidget: Text(
        _argument?.pickupLocation ?? '',
        style: AppTheme.kBodyMedium,
      ),
      subTitleWidget: Text(
          "${Helpers.getddMMMMyyhhmm(_argument?.pickupDate ?? DateTime.now())} - ${Helpers.getddMMMMyyhhmm(_argument?.returnDate ?? DateTime.now())}",
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)),
      onFilterButterPressed: () {},
    );
  }

  Widget _loadingWidget() {
    return const Expanded(child: OTALoadingIndicator());
  }

  Widget _failureWidget() {
    return Expanded(
      child: OtaSearchNoResultWidget(
        errorTextHeader: getTranslated(
          context,
          AppLocalizationsStrings.sorry,
        ),
        errorTextFooter: getTranslated(
          context,
          AppLocalizationsStrings.informationNotAvialable,
        ),
        paddingHeight: kSize8,
      ),
    );
  }

  Widget _successWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: _carSupplierList.length,
        padding: const EdgeInsets.only(top: kSize12, bottom: kSize48),
        itemBuilder: (context, index) {
          return CarSupplierCardWidget(
            key: const Key(_kCarSupplierCardWidgetKey),
            allowLateReturn: _carSupplierList[index].allowLateReturn,
            doors: _carSupplierList[index].car?.doorNbr ?? '',
            smallBags: _carSupplierList[index].car?.bagSmallNbr ?? '',
            gear: _carSupplierList[index].car?.gear ?? '',
            largeBags: _carSupplierList[index].car?.bagLargeNbr ?? '',
            seats: _carSupplierList[index].car?.seatNbr ?? '',
            imageUrl: _carSupplierList[index].supplier?.logo?.logoUrl,
            supplierName: _carSupplierList[index].supplier?.name ?? '',
            perDayPrice: _carSupplierList[index].pricePerDay ?? 0,
            totalPrice: _carSupplierList[index].totalPrice ?? 0,
            onPressed: () {
              getSupplierEvents(FirebaseEvent.carSupplierSelect,
                  _carSupplierList[index], index);
              _goToCarDetailScreen(_carSupplierList[index]);
            },
            onReserveButtonPressed: () {
              LoginModel loginModel = getLoginProvider();
              if (loginModel.userType == UserType.loggedInUser) {
                _goToCarReservationScreen(_carSupplierList[index]);
              } else {
                _showRegisterationAlert();
              }
            },
            returnLocation: _argument?.returnLocation ?? '',
            pickupLocation: _argument?.pickupLocation ?? '',
            returnExtraCharge: _carSupplierList[index].returnExtraCharge,
          );
        },
      ),
    );
  }

  void _showRegisterationAlert() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kSize24),
            topRight: Radius.circular(kSize24),
          ),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.kLight100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kSize24),
                        topRight: Radius.circular(kSize24))),
                child: OtaAlertBottomSheet(
                  leftButtonText:
                      getTranslated(context, AppLocalizationsStrings.cancel),
                  rightButtonText: getTranslated(context,
                      AppLocalizationsStrings.registerPopupRegisterButton),
                  alertText: getTranslated(
                      context, AppLocalizationsStrings.accountProceedLabel),
                  alertTitle: getTranslated(
                      context, AppLocalizationsStrings.registerPopupHeader),
                  onLeftButtonTap: () {
                    Navigator.pop(context);
                  },
                  onRightButtonTap: () {
                    waitForSuperAppToPushLandingPage();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  ///TODO: Need to update the arguments once the search result api is up.
  _goToCarDetailScreen(CarSupplierData carSupplierData) async {
    await Navigator.of(context).pushNamed(
      AppRoutes.carDetailScreen,
      arguments: CarDetailArgumentModel(
        carId: _argument?.carId ?? '',
        pickupLocationId: _argument?.pickupLocationId ?? '',
        returnLocationId: _argument?.returnLocationId ?? '',
        pickupDate: _argument?.pickupDate ?? DateTime.now(),
        returnDate: _argument?.returnDate ?? DateTime.now(),
        supplierId: carSupplierData.supplier?.id ?? '',
        includeDriver: _argument?.includeDriver ?? '',
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: _argument?.age ?? 0,
        cityName: _argument?.pickupLocation ?? '',
        pickupCounter: carSupplierData.pickupCounterId ?? '',
        returnCounter: carSupplierData.returnCounterId ?? '',

        ///TODO: Need to check if these values are required.
        // pickupCounter: '06',
        // returnCounter: '06',
        //residenceCountry: '',
        userType: getLoginProvider().userType.getCarDetailType(),
      ),
    );
    CarReservationUpdate carReservationUpdate =
        Provider.of<CarReservationUpdate>(context, listen: false);
    if (carReservationUpdate.isSupplierUpdated) {
      carReservationUpdate.supplierListUpdated();
      requestCarSupplierData();
    }
  }

  _goToCarReservationScreen(CarSupplierData carSupplierData) async {
    await Navigator.of(context).pushNamed(
      AppRoutes.carReservationScreen,
      arguments: CarReservationViewArgumentModel(
        carId: _argument?.carId ?? '',
        pickupLocationId: _argument?.pickupLocationId ?? '',
        returnLocationId: _argument?.returnLocationId ?? '',
        pickupDate: _argument?.pickupDate ?? DateTime.now(),
        returnDate: _argument?.returnDate ?? DateTime.now(),
        includeDriver: _argument?.includeDriver ?? '',
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: _argument?.age ?? 0,
        pickupCounter: carSupplierData.pickupCounterId,
        returnCounter: carSupplierData.returnCounterId,
        rateKey: carSupplierData.rateKey,
        refCode: carSupplierData.refCode,
        supplierId: carSupplierData.supplier?.id ?? '',
        lastPrice: carSupplierData.totalPrice,
      ),
    );
    CarReservationUpdate carReservationUpdate =
        Provider.of<CarReservationUpdate>(context, listen: false);
    if (carReservationUpdate.isSupplierUpdated) {
      carReservationUpdate.supplierListUpdated();
      requestCarSupplierData();
    }
  }

  void waitForSuperAppToPushLandingPage() {
    BookingCustomerRegisterUseCases landingCustomerRegisterUseCases =
        BookingCustomerRegisterUseCasesImpl();
    LoginModel loginModel = getLoginProvider();
    landingCustomerRegisterUseCases.invokeExampleMethod(
        methodName: "bookingCustomerRegister",
        arguments: BookingCustomerRegisterArgumentModelChannel(
          userType: loginModel.userType.getSuperAppString(),
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  void waitForReplyFromSuperApp(RegisterConfirmBookingModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    if (loginModel.userType == UserType.loggedInUser) {
      if (data.existingCust.toString().toLowerCase() == "no") {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(
            context,
            AppLocalizationsStrings.successRegistration,
          ),
          AppColors.kBannerCSuccessColor,
          _kTickIcon,
        );
      }
    }
  }

  List<String> _getAmenitiesList(List<PromotionListData> list) {
    List<String> amenitiesList = [];
    if (list.isNotEmpty) {
      amenitiesList.clear();
      for(PromotionListData item in list){
        if(item.line1 != null) {
          amenitiesList.add(item.line1!);
        }
      }
      return amenitiesList;
    } else {
      return amenitiesList;
    }
  }

  getSupplierEvents(String eventName,
      CarSupplierData carRecentSearchListViewModel, int index) {
    FirebaseHelper.startCapturingEvent(eventName);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarSupplierParametersFirebase.carModelId,
        value: _argument?.carId);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarSupplierParametersFirebase.carModelName,
        value: _argument?.carName);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarSupplierParametersFirebase.carSupplierId,
        value: carRecentSearchListViewModel.supplier?.id);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarSupplierParametersFirebase.carSupplierName,
        value: carRecentSearchListViewModel.supplier?.name);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: CarSupplierParametersFirebase.carSupplierSequence,
        value: index + 1);
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: CarSupplierParametersFirebase.carStartPrice,
        value: carRecentSearchListViewModel.pricePerDay);
  }
}
