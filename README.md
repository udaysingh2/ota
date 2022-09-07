# Robinhood OTA App

Flutter OTA app for Robinhood Super Apps

## Getting Started

    Get packages:
        flutter pub gett

    Build Android APK(ARM 32 and ARM 64):
        flutter build apk --target-platform android-arm,android-arm64 --split-per-abi

    Build for iOS (Requires XCode and will require firebase setup first):
        flutter build iOS

    Run on a physical device:
        flutter run --release

* Supported devices

    * Any android above API level 16
    * Any iOS device above iOS 8
    


* Naming Convention

    * Class names: PascalCase or UpperCamelCase | Eg: HomeScreen
    * File names (Dart or assets): snake_case or pothole_case | Eg: home_screen.dart
    * File names (Native Android or iOS): Follow native development conventions
    * Variable names: lowerCamelCase | Eg: String userFullName
    * Constant object names: lowerCamelCase starting with k | Eg: kCanvasBackgroundColor
    * ENUM values: lowerCamelCase | Eg: firstSelection

* Mandatory Project Module rules.
    * Class name should should have model name as prefix | Eg: LoginAuthScreen, LoginAuthModel.
    * Enum name should have model name as prefix | Eg: LoginViewState, LoginScreenState.
    * Module name should be unique throughout the hierarchy.
    * Main Ui Screen should have Screen as a suffix | Eg: LoginAuthScreen, ErrorTimeoutScreen
    * Please Dispose controllers and blocs in dispose method of stateful widget.
    * Domain models should have Domain as suffix | Eg: LoginModelDomain, ErrorDataDomain
    * Argument Models in Domain should have ArgumentModelDomain as suffix | Eg:  LoginArgumentModelDomain
    * Argument Models in View should have ArgumentModel as suffix | LoginUserArgumentModel


* Mandatory Android Studio Settings

    * Turn on format on save
    * Turn on organize imports on save
    * Keep the default max char length i.e. 80 chars


* Route from development to release

    * Maintainer will take a pull from the latest develop-feature branch (eg. develop-flights) and create an integration branch (eg. feature/flights/sprint1_integration)
    * Create a feature or a bugfix branch from integration branch
        * Branch name should either be feature/branch_name or bugfix/branch_name
        * feature/ or bugfix/ should be all lower case ONLY otherwise the pipeline fail
    * After making the required changes run the following commands in the terminal:
        * flutter test
        * flutter analyze
    * Once BOTH commands pass, commit the code and raise MR against the integration branch
    * Every MR requires at least 2 approvers to be merged
    * Once a sprint is over the maintainers will merge the sprint's integration branch into develop-feature
    * Once a service is ready to go into production it will be merged into develop branch
    * develop branch is merged to main branch
    * Release/prod build is triggered from master

### TODO Tesitng for Sonar 
