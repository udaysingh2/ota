import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_input_widget.dart';

void main() {
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  testWidgets('Car Search Input Widget Test...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CarSearchInputWidget(
          onChanged: (txt) {},
          searchTextController: searchTextController,
          searchHintText: 'test',
          focusNode: focusNode,
          onCrossButtonTap: () {
            OtaIconButton(
              icon: const Center(),
              onTap: () {},
            );
          },
          onSubmitted: (p0) {},
          onTextFieldTap: () {},
        ),
      ),
    ));
  });
}
