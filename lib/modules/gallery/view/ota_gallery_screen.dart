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
import 'package:ota/modules/gallery/view_model/gallery_argument_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';

const double _kGridPadding = 24.0;
const double _kGridItemSpacing = 15.0;
const int _kGridCrossAxisCount = 2;

class OtaGalleryScreen extends StatefulWidget {
  const OtaGalleryScreen({Key? key}) : super(key: key);

  @override
  OtaGalleryScreenState createState() => OtaGalleryScreenState();
}

class OtaGalleryScreenState extends State<OtaGalleryScreen> {
  final GalleryBloc _bloc = GalleryBloc();
  GalleryBloc get bloc => _bloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestGalleryData();
    });
    _bloc.stream.listen((event) {
      if (_bloc.state.galleryListViewModelState ==
              GalleryListViewModelState.internetFailure ||
          _bloc.state.galleryListViewModelState ==
              GalleryListViewModelState.internetFailureRefresh) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  Future<void> requestGalleryData({bool isPullToRefresh = false}) async {
    GalleryArgument argument =
        ModalRoute.of(context)?.settings.arguments as GalleryArgument;
    return _bloc.getGalleryImagesForService(
        argument: argument, isPullToRefresh: isPullToRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.tourGalleryLabel),
      ),
      body: BlocBuilder(
          bloc: _bloc,
          builder: () {
            return OtaRefreshIndicator(
              onRefresh: () async =>
                  await requestGalleryData(isPullToRefresh: true),
              text: _buildLoadingText(context),
              child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    _buildGalleryView(),
                    if (_bloc.state.galleryListViewModelState ==
                        GalleryListViewModelState.lazyDownLoading)
                      _buildFooterLoader()
                  ]),
            );
          }),
    );
  }

  Widget _buildFooterLoader() {
    return const SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(bottom: _kGridPadding),
      child: Center(child: CircularProgressIndicator()),
    ));
  }

  Widget _buildGalleryView() {
    switch (_bloc.state.galleryListViewModelState) {
      case GalleryListViewModelState.none:
      case GalleryListViewModelState.pullDownLoading:
        return _buildNoneWidget();
      case GalleryListViewModelState.loading:
        return _buildLoadingWidget();
      case GalleryListViewModelState.lazyDownLoading:
      case GalleryListViewModelState.success:
        return _bloc.state.galleryList.isEmpty
            ? _buildNoImagesWidget()
            : _buildSliverGrid();
      case GalleryListViewModelState.failure:
      case GalleryListViewModelState.internetFailure:
      case GalleryListViewModelState.internetFailureRefresh:
        return _buildErrorWidget();
    }
  }

  Widget _buildSliverGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(_kGridPadding),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (_bloc.isNewDataRequired(index)) {
              requestGalleryData();
            }
            return _buildImageView(index);
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

  Widget _buildImageView(int index) {
    return OtaRoundedCornerImage(
      key: Key("tourImage-$index"),
      imageUrl: _bloc.state.galleryList[index].imageUrl,
      onError: () {},
      onPressed: () {
        Navigator.push(
          context,
          OverlayImageViewer(
            imageList: _bloc.state.galleryList,
            initialPage: index,
          ),
        );
      },
      // no use of height/width just dummy data
      height: 1,
      width: 1,
    );
  }

  Widget _buildLoadingWidget() {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildNoneWidget() {
    return const SliverFillRemaining(
      child: SizedBox(),
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
            getTranslated(context, AppLocalizationsStrings.tourNoGalleryPhotos),
      ),
    );
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }
}
