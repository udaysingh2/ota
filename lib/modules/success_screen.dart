import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  SuccessScreenState createState() => SuccessScreenState();
}

class SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Payment success",
          style: AppTheme.kHBody,
        ),
        //Here is your code
      ),
    );
  }
}
