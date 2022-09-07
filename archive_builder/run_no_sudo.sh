cd archive_builder
APPLICATION_ID=""

if [ -z "$1" ]
  then
    echo 'Please enter bundle or package or application id (Ex: robinhood.flutter.ota)'
    read APPLICATION_ID
  else
    APPLICATION_ID="$1"
fi

echo  "App Id : ${APPLICATION_ID}"
rm -R gitdata
 rm -R build
 chmod a+rwx run.sh
#git clone https://github.com/nikhilishwarkulal/module_structure.git ./gitdata/
mkdir gitdata && cd $_
flutter create -t module --org $APPLICATION_ID flutter_module
cd ..
rm -rf ./gitdata/flutter_module/lib
cp -R ../lib ./gitdata/flutter_module/lib
rm ./gitdata/flutter_module/lib/core_components/ota_channel/ota_channel_config.dart
rm -rf ./gitdata/flutter_module/test
echo "
///Auto generated by Script
class OtaChannelConfig {
  static bool isModule = true;
}" > ./gitdata/flutter_module/lib/core_components/ota_channel/ota_channel_config.dart
rm -rf ./gitdata/flutter_module/assets
cp -R ../assets ./gitdata/flutter_module/assets
rm -rf ./gitdata/flutter_module/pubspec.yaml
cp  ../pubspec.yaml ./gitdata/flutter_module/pubspec.yaml
echo "" >> ./gitdata/flutter_module/pubspec.yaml
echo "  module:" >> ./gitdata/flutter_module/pubspec.yaml
echo "    androidX: true" >> ./gitdata/flutter_module/pubspec.yaml
echo "    androidPackage: ${APPLICATION_ID}" >> ./gitdata/flutter_module/pubspec.yaml
echo "    iosBundleIdentifier: ${APPLICATION_ID}" >> ./gitdata/flutter_module/pubspec.yaml
mkdir build
mkdir build/ios
mkdir build/android
chmod -R a+rwx ../archive_builder
cd gitdata
cd flutter_module
flutter clean
flutter pub get
cd .ios
pod install
cd ..
#flutter build ios-framework --xcframework --no-profile --output=../../build/ios/
flutter build ios-framework --output=../../build/ios/ --dart-define=GRAPHQL_BASE_URL_DEV=https://ota-api-interface-dev.np.scbtechx.io --dart-define=GRAPHQL_BASE_URL_ALPHA=https://ota-api-interface-alpha.np.scbtechx.io --dart-define=GRAPHQL_BASE_URL_PROD=https://ota-api-interface.scbtechx.io
flutter build aar  --dart-define=GRAPHQL_BASE_URL_DEV=https://ota-api-interface-dev.np.scbtechx.io --dart-define=GRAPHQL_BASE_URL_ALPHA=https://ota-api-interface-alpha.np.scbtechx.io --dart-define=GRAPHQL_BASE_URL_PROD=https://ota-api-interface.scbtechx.io
cp -R build/host/outputs/repo ../../build/android/repo
rm -rf ../../gitdata

