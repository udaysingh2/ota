// import 'package:flutter/material.dart';
// import 'package:ota/common/utils/app_colors.dart';
// import 'package:ota/common/utils/app_theme.dart';
// import 'package:ota/common/utils/consts.dart';
// import 'package:ota/common/utils/navigation_helper.dart';
// import 'package:ota/core_pack/i18n/language_codes.dart';
// import 'package:ota/modules/authentication/bloc/login_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../main.dart';
// import 'authentication/bloc/login_provider.dart';
// import 'authentication/model/login_model.dart';
// import 'demo_screen.dart';
//
// const String _loginText = 'Login';
// const String _userNameText = 'User Name';
// const String _passwordText = 'Password';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   late LoginModel _loginModel;
//   bool isValidEntryUser = false;
//   bool isValidEntryPassword = false;
//   bool _isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//     _loginModel = Provider.of<LoginModel>(
//         GlobalKeys.navigatorKey.currentContext!,
//         listen: false);
//     if (_loginModel.state == LoginState.refreshTokenExpired) {
//       Future.delayed(Duration(seconds: 0)).then((_) {
//         this.showSnackBar('Your session has expired, please login');
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? Center(child: CircularProgressIndicator())
//         : Scaffold(
//             floatingActionButton: FloatingActionButton(
//               child: Icon(Icons.translate),
//               onPressed: () {
//                 final currentLocale = MyApp.getLocal(context);
//                 final newLocale =
//                     LanguageCodes.thai.code == currentLocale.languageCode
//                         ? kEngLocale
//                         : kThaiLocale;
//
//                 MyApp.setLocale(context, newLocale);
//               },
//             ),
//             appBar: AppBar(
//               title: Text(
//                 _loginText,
//                 style: AppTheme.kHeading2,
//               ),
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.blue,
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       _loginModel.userType = UserType.guestUser;
//                       _handleDefaultLogin();
//                     },
//                     child:
//                         Text("Guest", style: TextStyle(color: Colors.black54)))
//               ],
//             ),
//             body: buildForm(),
//           );
//   }
//
//   Widget buildForm() {
//     return Padding(
//       padding: EdgeInsets.all(kSize20),
//       child: ListView(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(kSize10),
//             child: TextField(
//               onChanged: (inputValue) {
//                 setValidatorUser(inputValue);
//               },
//               controller: _nameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: _userNameText,
//                 errorText:
//                     isValidEntryUser ? null : "Enter minimum 4 character",
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.fromLTRB(kSize10, kSize10, kSize10, kSize0),
//             child: TextField(
//               onChanged: (inputValue) {
//                 setValidatorPassword(inputValue);
//               },
//               obscureText: true,
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: _passwordText,
//                 errorText:
//                     isValidEntryPassword ? null : "Enter minimum 4 character",
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//               height: 50,
//               padding: EdgeInsets.fromLTRB(kSize10, kSize0, kSize10, kSize0),
//               child: ElevatedButton(
//                 child: Text(
//                   _loginText,
//                   style:
//                       AppTheme.kHeading2.copyWith(color: AppColors.kLight100),
//                 ),
//                 onPressed: (isValidEntryUser && isValidEntryPassword)
//                     ? () {
//                         _loginModel.userType = UserType.loggedInUser;
//                         _handleLogin();
//                       }
//                     : null,
//               )),
//           const SizedBox(
//             height: kSize40,
//           ),
//           Container(
//               height: 50,
//               padding: EdgeInsets.fromLTRB(kSize10, kSize0, kSize10, kSize0),
//               child: ElevatedButton(
//                 child: Text(
//                   "Login with user",
//                   style:
//                       AppTheme.kHeading2.copyWith(color: AppColors.kLight100),
//                 ),
//                 onPressed: () {
//                   _loginModel.userType = UserType.loggedInUser;
//                   _handleDefaultLogin();
//                 },
//               )),
//         ],
//       ),
//     );
//   }
//
//   void setValidatorUser(text) {
//     bool valid = false;
//     if (text.length >= 4) {
//       valid = true;
//     }
//     setState(() {
//       isValidEntryUser = valid;
//     });
//   }
//
//   void setValidatorPassword(text) {
//     bool valid = false;
//     if (text.length >= 4) {
//       valid = true;
//     }
//     setState(() {
//       isValidEntryPassword = valid;
//     });
//   }
//
//   void _handleDefaultLogin() async {
//     _nameController.text = "otadevuser";
//     _passwordController.text = "otadevpass";
//     // if (kEnvType == "alpha") {
//     //   _nameController.text = "otaalphauser";
//     //   _passwordController.text = "otaalphapass";
//     // }
//
//     isValidEntryUser = true;
//     isValidEntryPassword = true;
//     _handleLogin();
//   }
//
//   void _handleLogin() async {
//     setState(() {
//       _isLoading = true;
//     });
//     bool result = await LoginProvider.getLoginDetailData(
//         username: _nameController.text, password: _passwordController.text);
//     setState(() {
//       _isLoading = false;
//     });
//     if (!result) this.showSnackBar('Unable to login');
//     isValidEntryPassword = false;
//     isValidEntryUser = false;
//     _nameController.clear();
//     _passwordController.clear();
//   }
//
//   void showSnackBar(String message) {
//     final snackBar = SnackBar(
//       content: Text(message),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
