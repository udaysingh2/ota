import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/modules/gallery/view/widgets/gallery_detail_placeholder.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('gallery detail placeholder ...', (tester) async {
    Widget widget = getMaterialWrapper(const GalleryDetailPlaceholder());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsNWidgets(2));
  });
  testWidgets('gallery detail error placeholder...', (tester) async {
    Widget widget = getMaterialWrapper(const GalleryDetailPlaceholder(
      isError: true,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(OtaNetworkErrorWidget), findsOneWidget);
  });
}
