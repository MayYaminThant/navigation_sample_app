# dh_mobile
Flutter Application for Domestic Helper.
```
Flutter 3.7.11 • channel stable • https://github.com/flutter/flutter.git
Framework revision f72efea43c (2 months ago), 2023-04-11 11:57:21 -0700
Engine • revision 1a65d409c7
Tools • Dart 2.19.6 • DevTools 2.20.1
```
## Getting Started

#### 1. Clone and Install

```bash
# Clone the repo
git clone https://github.com/phluidworld/dh_mobile.git

# Navigate to clonned folder and Install dependencies
cd dh_mobile && flutter packages get
```

#### 2. Run
```bash

# For IOS
cd ios && -rm-rf Podfile.lock

#Reinstall the cocapods
pod install

# Run the app
flutter run
```

## Directory Structure
```
📂android
📂assets
└───📂fonts
└───📂icons
└───📂images
└───📂ringtone
└───📂svg
📂ios
📂lib
 │───main.dart  
 └───📂src
     └─── 📂config
     |    │────📂routes
     |    │────📂themes
     |    └────📂utils
     └────📂core
     |    │────📂bloc
     |    │────📂controllers
     |    │────📂middlewares
     |    │────📂params
     |    │────📂resources
     |    └────📂usecases
     └────📂data
     |    │────📂datasources
     |    |    │────📂local
     |    |    └────📂remote
     |    │────📂models
     |    └────📂repositories
     └────📂domain
     |    │────📂entities
     |    │────📂repositories
     |    └────📂usecases
     └────📂presentations
     |    │────📂blocs
     |    │────📂values
     |    │────📂views
     |    └────📂widgets
     └────injector.dart

```

## Dependencies
Package Name        |
:-------------------------|
|[GetX](https://pub.dev/packages/get) 
|[flutter_bloc](https://pub.dev/packages/bottom_navy_bar) 
|[dio](https://pub.dev/packages/dio)
|[retrofit](https://pub.dev/packages/retrofit)
|[flutter_hooks](https://pub.dev/packages/flutter_hooks)
|[google_fonts](https://pub.dev/packages/google_fonts)
|[cached_network_image](https://pub.dev/packages/cached_network_image)
|[flutter_easyloading](https://pub.dev/packages/flutter_easyloading)
|[file_picker](https://pub.dev/packages/file_picker)
|[firebase_dynamic_links](https://pub.dev/packages/firebase_dynamic_links)
|[zego_uikit_prebuilt_call](https://pub.dev/packages/zego_uikit_prebuilt_call)

others in pubspec.yaml
<br/>

```flutter packages pub run build_runner build --delete-conflicting-outputs```

### flutter 3.7.12
### zego_uikit 2.7.6