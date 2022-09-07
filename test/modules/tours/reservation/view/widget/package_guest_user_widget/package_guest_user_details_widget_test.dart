import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_detail_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_details_widget.dart';

import '../../../../../../helper.dart';



void main() {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  FocusNode focusNodeGuestFirstName = FocusNode();
  FocusNode focusNodeGuestLastName = FocusNode();
  FocusNode focusNodeGuestMobileNumber = FocusNode();
  PackageGuestUserDetailController controller = PackageGuestUserDetailController();
  testWidgets('Package Guest User Details Widget', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(PackageGuestUserDetailWidget(
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      mobileNumberController: mobileNumberController,
      guestMobileNumber: focusNodeGuestMobileNumber,
      guestLastName: focusNodeGuestLastName,
      guestFirstName: focusNodeGuestFirstName,
      onRadioBtnClicked: (){},
      packageGuestUserDetailController: controller,
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);

    await tester.pumpAndSettle();
    await tester.tap(find.byType(Text).first);
    await tester.pump();

  });
}