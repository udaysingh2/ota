import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_matching_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_rounded_corner_image.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_gallery/bloc/car_gallery_bloc.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_argument_model.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

import 'gallery_details/car_overlay_image_viewer.dart';

const double _kGridPadding = 24.0;
const double _kGridItemSpacing = 15.0;
const int _kGridCrossAxisCount = 2;
const double _kRemainingPixels = 50.0;
const int _kVisibleItems = 7;

class CarGalleryScreen extends StatefulWidget {
  const CarGalleryScreen({Key? key}) : super(key: key);

  @override
  CarGalleryScreenState createState() => CarGalleryScreenState();
}

class CarGalleryScreenState extends State<CarGalleryScreen> {
  final CarGalleryBloc _bloc = CarGalleryBloc();
  ScrollController? _scrollController;
  CarGalleryBloc get bloc => _bloc;
  scrollListener() {
    /// Reached at end of list
    if (_scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.position.extentAfter <= _kRemainingPixels &&
        _bloc.state.galleryList.length >= _kVisibleItems) {
      /// If gallery data is data loading in progress then return
      if (_bloc.state.galleryListViewModelState ==
          CarGalleryViewModelState.loading) {
        return;
      }
      requestGalleryData();
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController!.addListener(scrollListener);
    _bloc.stream.listen((event) {
      if (_bloc.state.galleryListViewModelState ==
          CarGalleryViewModelState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestGalleryData();
    });
  }

  Future<void> requestGalleryData({bool isPullToRefresh = false}) async {
    CarGalleryArgumentModel argument =
        ModalRoute.of(context)?.settings.arguments as CarGalleryArgumentModel;
    return _bloc.getGalleryImages(
        argument: argument, isPullToRefresh: isPullToRefresh);
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width -
        ((2 * _kGridItemSpacing) + _kGridItemSpacing);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.carGallery),
      ),
      body: BlocBuilder(
          bloc: _bloc,
          builder: () {
            bool isLoading = _bloc.state.galleryListViewModelState ==
                    CarGalleryViewModelState.loading &&
                _bloc.state.galleryList.isEmpty;
            bool isLazyLoading = _bloc.state.galleryListViewModelState ==
                    CarGalleryViewModelState.loading &&
                _bloc.state.galleryList.isNotEmpty;
            bool isFailure = (_bloc.state.galleryListViewModelState ==
                        CarGalleryViewModelState.failure ||
                    _bloc.state.galleryListViewModelState ==
                        CarGalleryViewModelState.failureNetwork) &&
                _bloc.state.galleryList.isEmpty;
            bool isSuccessEmpty = _bloc.state.galleryListViewModelState ==
                    CarGalleryViewModelState.success &&
                _bloc.state.galleryList.isEmpty;
            bool pullDownLoading = _bloc.state.galleryListViewModelState ==
                    CarGalleryViewModelState.pullDownLoading &&
                _bloc.state.galleryList.isNotEmpty;
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return OtaRefreshIndicator(
              onRefresh: () async =>
                  await requestGalleryData(isPullToRefresh: true),
              text: _buildLoadingText(context),
              child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  slivers: [
                    if (isSuccessEmpty) _buildNoImagesWidget(),
                    if (isFailure && !isSuccessEmpty) _buildErrorWidget(),
                    if (!isFailure) _buildSliverGrid(itemWidth),
                    if (isLazyLoading & !pullDownLoading) _buildFooterLoader(),
                  ]),
            );
          }),
    );
  }

  Widget _buildSliverGrid(double itemWidth) {
    return SliverPadding(
      padding: const EdgeInsets.all(_kGridPadding),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildImageView(itemWidth, index);
          },
          childCount: _bloc.state.galleryList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _kGridCrossAxisCount,
          crossAxisSpacing: _kGridItemSpacing,
          mainAxisSpacing: _kGridItemSpacing,
        ),
      ),
    );
  }

  Widget _buildImageView(double itemWidth, int index) {
    return OtaRoundedCornerImage(
      key: Key(_bloc.state.galleryList[index].thumb),
      imageUrl: _bloc.state.galleryList[index].thumb,
      width: itemWidth,
      height: itemWidth,
      onError: () {
        _bloc.removeImageOnError(_bloc.state.galleryList[index].thumb);
      },
      onPressed: () {
        Navigator.push(
          context,
          CarOverlayImageViewer(
            imageList: _bloc.state.galleryList,
            initialPage: index,
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    return const SliverFillRemaining(
      child: OtaNetworkErrorWidget(),
    );
  }

  Widget _buildNoImagesWidget() {
    return SliverFillRemaining(
      child: OtaNoMatchingResultWidget(
        errorTextHeader: getTranslated(context, AppLocalizationsStrings.sorry),
        errorTextFooter:
            getTranslated(context, AppLocalizationsStrings.noPhotos),
      ),
    );
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }

  Widget _buildFooterLoader() {
    return SliverToBoxAdapter(
      child: _bloc.state.galleryListViewModelState ==
              CarGalleryViewModelState.loading
          ? const Padding(
              padding: EdgeInsets.only(bottom: _kGridPadding),
              child: Center(child: CircularProgressIndicator()),
            )
          : const SizedBox(),
    );
  }
}
