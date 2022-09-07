import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/modules/gallery/bloc/gallery_bloc.dart';
import 'package:ota/modules/gallery/view/ota_gallery_screen.dart';
import 'package:ota/modules/gallery/view_model/gallery_argument_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  testWidgets('OTA Gallery Screen Test', (tester) async {
    GlobalKey<OtaGalleryScreenState> key = GlobalKey();
    final GalleryArgument argument =
        GalleryArgument(serviceId: "MA2110000413", serviceName: "Tour");
    Widget widget = getMaterialWrapperWithArguments(
        OtaGalleryScreen(
          key: key,
        ),
        AppRoutes.galleryOtaScreen,
        argument);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    GalleryBloc galleryBloc = key.currentState?.bloc ?? GalleryBloc();
    galleryBloc.state.galleryList = [];
    galleryBloc.emit(GalleryListViewModel(
        galleryList: [],
        galleryListViewModelState: GalleryListViewModelState.loading));
    await tester.pump();
    expect(find.byType(OtaAppBar), findsOneWidget);
    expect(find.byType(Padding), findsWidgets);
    await tester.pump();
    galleryBloc.emit(GalleryListViewModel(
        galleryList: [],
        galleryListViewModelState: GalleryListViewModelState.success));
    await tester.pump();
    galleryBloc.emit(GalleryListViewModel(galleryList: [
      GalleryViewModel(
        imageUrl:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      ),
      GalleryViewModel(
        imageUrl:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      )
    ], galleryListViewModelState: GalleryListViewModelState.loading));
    await tester.pump();
    galleryBloc.emit(GalleryListViewModel(galleryList: [
      GalleryViewModel(
        imageUrl:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      ),
      GalleryViewModel(
        imageUrl:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      )
    ], galleryListViewModelState: GalleryListViewModelState.success));
    await tester.pump();
  });
}
