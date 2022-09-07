import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_search/results/view/widgets/ota_search_no_result_with_refresh.dart';
import '../../../../helper/material_wrapper.dart';

void main(){
  testWidgets('Ota Search No result with Refresh', (tester) async {
    Widget widget = getMaterialWrapper(OtaSearchNoResultRefresh(
      height: 400,
      onRefresh: () async{},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}