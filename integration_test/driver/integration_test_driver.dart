import 'dart:io';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  final Map<String, String> envVars = Platform.environment;
  String platFormAdbPath =
      '/platform-tools/${Platform.isWindows ? 'adb.exe' : 'adb'}';
  String adbPath = '${envVars['ANDROID_SDK_ROOT']}$platFormAdbPath';
  print('adb path is: $adbPath');
  adbPath = 'adb';
  /* un comment when
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'th.in.robinhood.rider.dev',
    'android.permission.CAMERA'
  ]);
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'th.in.robinhood.rider.dev',
    'android.permission.ACCESS_BACKGROUND_LOCATION'
  ]);
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'th.in.robinhood.rider.dev',
    'android.permission.ACCESS_COARSE_LOCATION'
  ]);
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'th.in.robinhood.rider.dev',
    'android.permission.ACCESS_FINE_LOCATION'
  ]);
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'th.in.robinhood.rider.dev',
    'android.permission.WRITE_EXTERNAL_STORAGE'
  ]);
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'th.in.robinhood.rider.dev',
    'android.permission.USE_FINGERPRINT'
  ]);
*/
  await integrationDriver();
}
