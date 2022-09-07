import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';

void main() {
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  testWidgets('OTA Search Input Widget Test...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: OtaSearchInputWidget(
          onChanged: (enteredText) {},
          searchTextController: searchTextController,
          searchHintText: 'test',
          focusNode: focusNode,
        ),
      ),
    ));
  });
}
