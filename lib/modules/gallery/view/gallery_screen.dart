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
import 'package:ota/modules/gallery/bloc/gallery_bloc.dart';
import 'package:ota/modules/gallery/view/gallery_details/overlay_image_viewer.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

const double _kGridPadding = 24.0;
const double _kGridItemSpacing = 15.0;
const int _kGridCrossAxisCount = 2;
const double _kRemainingPixels = 50.0;
const int _kVisisbleItems = 7;

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  GalleryScreenState createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> {
  final GalleryBloc _bloc = GalleryBloc();
  ScrollController? _scrollController;
  GalleryBloc get bloc => _bloc;
  scrollListener() {
    /// Reached at end of list
    if (_scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.position.extentAfter <= _kRemainingPixels &&
        _bloc.state.galleryList.length >= _kVisisbleItems) {
      /// If gallery data is data loading in progress then return
      if (_bloc.state.galleryListViewModelState ==
              GalleryListViewModelState.loading ||
          _bloc.state.isInternetFailurePopupShown) {
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestGalleryData();
    });

    _bloc.stream.listen((event) {
      if (_bloc.state.galleryListViewModelState ==
              GalleryListViewModelState.internetFailure ||
          _bloc.state.galleryListViewModelState ==
              GalleryListViewModelState.internetFailureRefresh) {
        OtaNoInternetAlertDialog().showAlertDialog(context, onOkClick: () {
          _bloc.state.isInternetFailurePopupShown = false;
          Navigator.of(context).pop();
        });
        _bloc.setInternetPopupShown();
      }
    });
  }

  Future<void> requestGalleryData({bool isPullToRefresh = false}) async {
    HotelDetailArgument argument =
        ModalRoute.of(context)?.settings.arguments as HotelDetailArgument;
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
        title: getTranslated(context, AppLocalizationsStrings.gallery),
      ),
      body: BlocBuilder(
          bloc: _bloc,
          builder: () {
            bool isLoading = _bloc.state.galleryListViewModelState ==
                    GalleryListViewModelState.loading &&
                _bloc.state.galleryList.isEmpty;
            bool isLazyLoading = _bloc.state.galleryListViewModelState ==
                    GalleryListViewModelState.loading &&
                _bloc.state.galleryList.isNotEmpty;
            bool isFailure = (_bloc.state.galleryListViewModelState ==
                        GalleryListViewModelState.failure ||
                    _bloc.state.galleryListViewModelState ==
                        GalleryListViewModelState.internetFailure ||
                    _bloc.state.galleryListViewModelState ==
                        GalleryListViewModelState.internetFailureRefresh) &&
                _bloc.state.galleryList.isEmpty;
            bool isSuccessEmpty = _bloc.state.galleryListViewModelState ==
                    GalleryListViewModelState.success &&
                _bloc.state.galleryList.isEmpty;
            bool pullDownLoading = _bloc.state.galleryListViewModelState ==
                    GalleryListViewModelState.pullDownLoading &&
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
            return _buildImageView(
                itemWidth, _bloc.state.galleryList[index].imageUrl, index);
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

  Widget _buildImageView(double itemWidth, String imageUrl, int index) {
    return OtaRoundedCornerImage(
      key: Key(_bloc.state.galleryList[index].imageUrl),
      imageUrl: _bloc.state.galleryList[index].imageUrl,
      width: itemWidth,
      height: itemWidth,
      onError: () {
        _bloc.removeImageOnError(imageUrl);
      },
      onPressed: () {
        Navigator.push(
          context,
          OverlayImageViewer(
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
              GalleryListViewModelState.loading
          ? const Padding(
              padding: EdgeInsets.only(bottom: _kGridPadding),
              child: Center(child: CircularProgressIndicator()),
            )
          : const SizedBox(),
    );
  }
}
