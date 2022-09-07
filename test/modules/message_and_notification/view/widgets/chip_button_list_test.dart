import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/modules/message_and_notification/view/widgets/chip_button_list.dart';

import '../../../../helper/material_wrapper.dart';

const String _specialForYouKey = "specialForYouKey";
const String _newsPromotionKey = "newsPromotionKey";
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Chip Button List Widget", () {
    testWidgets("Chip Button List Widget", (tester) async {
      OtaRadioOptionListBloc bloc = OtaRadioOptionListBloc();
      Widget widget = getMaterialWrapper(
        MessageAndNotificationChipButton(
          onEReciptsTap: () {},
          onNotificationTap: () {},
          otaRadioOptionListBloc: bloc,
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(_specialForYouKey)).first);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(_newsPromotionKey)).first);
      await tester.pumpAndSettle();
    });
  });
}
