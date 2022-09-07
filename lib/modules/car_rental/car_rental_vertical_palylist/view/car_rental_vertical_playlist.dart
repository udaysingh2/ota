import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/bloc/car_rental_vertical_playlist_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view/widgets/car_vertical_static_card_widget.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_view_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/search/helpers/ota_search_util.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';

class CarRentalVerticalPlaylistScreen extends StatefulWidget {
  const CarRentalVerticalPlaylistScreen({Key? key}) : super(key: key);

  @override
  CarRentalVerticalPlaylistScreenState createState() =>
      CarRentalVerticalPlaylistScreenState();
}

class CarRentalVerticalPlaylistScreenState
    extends State<CarRentalVerticalPlaylistScreen> {
  final CarRentalVerticalPlaylistBloc _otaSearchBloc =
      CarRentalVerticalPlaylistBloc();
  final ScrollController _scrollController = ScrollController();
  OtaSearchUtil? _otaSearchUtil;
  CarVerticalArgumentViewModel? _viewArgument;

  @override
  void dispose() {
    _scrollController.dispose();
    _otaSearchBloc.dispose();
    super.dispose();
  }

  _getCarData() {
    OtaSearchViewArgument otaSearchViewArgument =
        _otaSearchUtil!.getArguments();
    _otaSearchBloc.getCarDataWithOffset(otaSearchViewArgument);
  }

  @override
  void initState() {
    super.initState();
    _otaSearchBloc.stream.listen((event) {
      if (_otaSearchBloc.state.pageState ==
              CarVerticalListPageState.internetFailure &&
          !event.isInternetFailurePopUpShown) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _otaSearchBloc.setPopUpShown();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List arguments = ModalRoute.of(context)?.settings.arguments as List;
      _otaSearchUtil = arguments[0];
      _viewArgument = arguments[1];
      _otaSearchBloc.mapCarDataFromArgument(_viewArgument);
    });
  }

  @override
  Widget build(BuildContext context) {
    List? arguments = ModalRoute.of(context)?.settings.arguments as List?;
    _viewArgument = arguments?[1];
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListView(),
    );
  }

  OtaAppBar _buildAppBar() {
    return OtaAppBar(
      title: _viewArgument?.locationName,
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.customTrailingWidget
      ],
    );
  }

  Widget _buildListView() {
    return BlocBuilder(
      bloc: _otaSearchBloc,
      builder: () {
        List<CarVerticalList>? carModelList =
            (_otaSearchBloc.state.carRentalVerticalData?.carModelList) ?? [];
        if (_otaSearchBloc.state.pageState ==
                CarVerticalListPageState.success ||
            (_otaSearchBloc
                    .state.carRentalVerticalData?.carModelList?.isNotEmpty ??
                false)) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: carModelList.length,
            padding:
                const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize24),
            itemBuilder: (context, index) {
              if (_otaSearchBloc.isNewDataRequired(index)) {
                _getCarData();
              }
              return _buildOtaSuggestionCard(carModelList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: kSize16);
            },
          );
        } else if (_otaSearchBloc.state.pageState ==
                CarVerticalListPageState.internetFailure &&
            (_otaSearchBloc
                    .state.carRentalVerticalData?.carModelList?.isEmpty ??
                false)) {
          return const OtaNetworkErrorWidget();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildOtaSuggestionCard(CarVerticalList carRentalModel) {
    return CarVerticalStaticPlaylistCard(
      model: carRentalModel,
      isInHorizontalScroll: false,
      onPress: () {
        _navigateToCarSupplierScreen(carRentalModel, context);
      },
    );
  }

  void _navigateToCarSupplierScreen(
      CarVerticalList carModel, BuildContext context) {
    CarSupplierArgumentViewModel argumentModel = CarSupplierArgumentViewModel();

    argumentModel = CarSupplierArgumentViewModel(
        pickupLocationId:
            _otaSearchBloc.state.carRentalVerticalData?.pickupLocationId ?? '',
        returnLocationId:
            _otaSearchBloc.state.carRentalVerticalData?.returnLocationId ?? '',
        pickupDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
          Duration(
            days: AppConfig().configModel.pickUpDeltaCar,
            hours: 10,
          ),
        ),
        returnDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
          Duration(
            days: AppConfig().configModel.dropOffDeltaCar,
            hours: 10,
          ),
        ),
        carId: carModel.carId.toString(),
        includeDriver: AppConfig().configModel.includeDriver,
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: AppConfig().configModel.carDriverDefaultAge,
        craftType: carModel.carInfo?.carTypeName ?? '',
        residenceCountry: '',
        carName: carModel.modelName,
        brandName: carModel.brandName,
        pickupLocation: _otaSearchUtil?.searchKey ?? '',
        pickupCounter: AppConfig().configModel.pickupCounter,
        returnCounter: AppConfig().configModel.returnCounter,
        thumbImage: carModel.images?.thumb);

    Navigator.pushNamed(
      context,
      AppRoutes.carSupplierScreen,
      arguments: argumentModel,
    );
  }
}
