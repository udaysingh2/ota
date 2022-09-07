import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/modules/gallery/bloc/gallery_bloc.dart';
import 'package:ota/modules/gallery/view/gallery_screen.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

import '../../../helper/material_wrapper.dart';
import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  testWidgets('Gallery Screen Test', (tester) async {
    GlobalKey<GalleryScreenState> key = GlobalKey();
    final HotelDetailArgument argument = getHotelDetailArgumentMock();
    Widget widget = getMaterialWrapperWithArguments(
        GalleryScreen(
          key: key,
        ),
        AppRoutes.galleryScreen,
        argument);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    GalleryBloc galleryBloc = key.currentState?.bloc ?? GalleryBloc();
    galleryBloc.state.galleryList = [];
    galleryBloc.emit(GalleryListViewModel(
        galleryList: [],
        galleryListViewModelState: GalleryListViewModelState.loading));
    await tester.pump();
    key.currentState?.scrollListener();
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
