import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_add_on_service_card.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/bloc/hotel_addon_service_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/helpers/hotel_addon_service_helper.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_view_model.dart'
    as calendar_view_model;

const double _kGridItemHorizontalSpacing = 28.0;
const double _kGridItemVerticalSpacing = 8.0;
const int _kGridCrossAxisCount = 2;

class HotelAddonServiceScreen extends StatefulWidget {
  const HotelAddonServiceScreen({Key? key}) : super(key: key);

  @override
  HotelAddonServiceScreenState createState() => HotelAddonServiceScreenState();
}

class HotelAddonServiceScreenState extends State<HotelAddonServiceScreen> {
  final HotelAddonServiceBloc _bloc = HotelAddonServiceBloc();
  final ScrollController _scrollController = ScrollController();
  HotelServiceViewArgument? _hotelServiceViewArgument;

  _scrollListener() {
    /// Reached at end of list
    if (_scrollController.hasClients &&
        _scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      /// If hotel addon service data is data loading in progress then return
      if (_bloc.state.addonServiceState == HotelServiceViewModelState.loading) {
        return;
      }

      _requestAddonServiceData();
    }
  }

  Future<void> _requestAddonServiceData({bool isPullToRefresh = false}) async {
    _hotelServiceViewArgument =
        ModalRoute.of(context)?.settings.arguments as HotelServiceViewArgument;
    return _bloc.getHotelAddonServiceData(
        viewArgument: _hotelServiceViewArgument,
        isPullToRefresh: isPullToRefresh);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestAddonServiceData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.recommendedServices),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: () {
          if (_bloc.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return OtaRefreshIndicator(
            onRefresh: () async =>
                await _requestAddonServiceData(isPullToRefresh: true),
            text: _buildLoadingText(context),
            child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: _scrollController,
                slivers: [
                  if (_bloc.isFailure && !_bloc.isSuccessEmpty)
                    _buildErrorWidget(),
                  if (!_bloc.isFailure) _buildSliverGrid(),
                  _buildFooterLoader(),
                ]),
          );
        },
      ),
    );
  }

  Widget _buildSliverGrid() {
    return SliverPadding(
      padding:
          const EdgeInsets.symmetric(vertical: kSize8, horizontal: kSize24),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildImageView(index),
          childCount: _bloc.state.addonServiceList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _kGridCrossAxisCount,
          crossAxisSpacing: _kGridItemHorizontalSpacing,
          mainAxisSpacing: _kGridItemVerticalSpacing,
        ),
      ),
    );
  }

  Widget _buildImageView(int index) {
    final addonServiceViewModel = _bloc.state.addonServiceList[index];
    return OtaAddOnServiceCard(
      hotelServiceName: addonServiceViewModel.serviceName,
      currency: addonServiceViewModel.currency,
      price: addonServiceViewModel.price,
      imageUrl: addonServiceViewModel.imageUrl,
      isInHorizonalScroll: true,
      onPress: () async {
        final serviceCalendarArgument = AddonServiceCalendarArgument(
          price: addonServiceViewModel.price,
          title: addonServiceViewModel.serviceName,
          description: addonServiceViewModel.description,
          checkInDate: _hotelServiceViewArgument?.checkInDate ?? '',
          checkOutDate: _hotelServiceViewArgument?.checkOutDate ?? '',
          preselectedDates: HotelAddonServiceHelper.getSelectedDatesOfService(
            _hotelServiceViewArgument?.selectedAddons ?? [],
            addonServiceViewModel.serviceId,
          ),
          noOfAdults: addonServiceViewModel.noOfAdults ??
              AppConfig().configModel.defaultAdultCount,
          currency: addonServiceViewModel.currency,
          imageUrl: addonServiceViewModel.imageUrl,
          uniqueId: addonServiceViewModel.serviceId,
          isFlight: addonServiceViewModel.isFlight,
        );
        var data = await Navigator.pushNamed(
            context, AppRoutes.addonServiceCalendarScreen,
            arguments: serviceCalendarArgument);
        if (data != null && _hotelServiceViewArgument?.onUpdate != null) {
          _hotelServiceViewArgument
              ?.onUpdate!(data as calendar_view_model.AddonServiceViewModel);
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget _buildErrorWidget() {
    return const SliverFillRemaining(child: OtaNetworkErrorWidget());
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }

  Widget _buildFooterLoader() {
    return SliverToBoxAdapter(
      child: _bloc.isLazyLoading && !_bloc.pullDownLoading
          ? const Padding(
              padding: EdgeInsets.only(bottom: kSize24),
              child: Center(child: CircularProgressIndicator()),
            )
          : const SizedBox(),
    );
  }
}
