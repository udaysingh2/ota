import 'package:flutter/material.dart';
import 'package:ota/modules/splash/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'authentication/model/login_model.dart';

class AuthLanding extends StatefulWidget {
  const AuthLanding({Key? key}) : super(key: key);

  @override
  AuthLandingState createState() => AuthLandingState();
}

class AuthLandingState extends State<AuthLanding> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginModel>(
      builder: (context, value, child) {
        return const Scaffold(
          body: SplashScreen(),
        );
      },
    );
  }
}
