# Flutter Template
This is the flutter architecture template description:
## Setup Directories 
This architecture divided into five principal folders 

### Core/providers
The providers folder contains our providers to connect the UI and application logic .
In fact, It’s a state management helper that contains some data and notifies observers when a change occurs.
Besides, this folder has a base provider class which is extended by all provider classes. In fact, this class extends a ChangeNotifier and declares three method:
1. setState(ViewState value): This method sets the state of the view to the desired value.
2. setStateAndNotifyListeners(ViewState value): This method has the same functionality as setState method with the addition of a notifyListeners() to notify its listeners. 
3. clearError(): As the name indicates, this method allows to clear the error after used it.

### Core/services
The Services folder contains the classes that make external calls, then transfer the obtained results to providers classes.
This folder has a base service class which is extended by all the service classes, in fact, this class holds basic HTTP methods.

### Core/models
The models folder holds classes that represent data and functionality. 
Besides, this folder contains an error model class that's used when an error occurred.

### Core/enums
The enums folder contains enumeration classes that used for defining named constant values.

### ui
The ui folder houses all the code for building screens.

## Setup Internationalization

### Step1:
Add flutter Intl plugin :

1. Install flutter Intl plugin : Settings >> plugins >> Flutter Intl >> Install
2. Activate the plugin for the project:

<img src="assets/readmeImage.png" />

This plugin will generate two folders: lib/generated/i10n and lib/i10n.

### Step2:

Add new string values:

all you have to do is to make a new file in lib/I10n with .arb extension.
In this file, add your values:
```json
{
"title" : "Flutter Architecture",
  "@title": {
    "type": "text",
    "placeholders": {}
  }
}
```
values will automatically add in lib/generated/I10n.dart file and update files in lib/generated/intl thanks to flutter Intl plugin .
For more details: [flutter intl plugin](https://plugins.jetbrains.com/plugin/13666-flutter-intl)

## Setup Routes/locator

### Routes:
For navigation we use auto_route library. In fact, this is a route generation library, where everything needed for navigation is automatically generated for you.
### Locator:
For dependency injection  we use get_it and injectable. 
In fact, get_it is a simple service Locator for Dart and Flutter projects and Injectable is a convenient code generator for this service.

#### Step1:
Add new route with the desired name in lib/utils/navigation_setup file,
besides add new locator in lib/utils/locator_setup file, you must specify the way that you want to register your object by one of the annotations: @factoryMethod, @lazySingleton.

#### Step2:
Run the generator: 
```
flutter pub run build_runner build --delete-conflicting-outputs

```
This command will create router. gr.dart and locator.iconfig.dart files that contain all the required code for routing and locator setup.

## Setup Responsive Ui 

This feature is divided into four principal classes :

1. orientation_layout: This class allows us to determine device orientation either landscape or portrait.
2. sizing_information: Before we create this class we need an enum that represents our device screen type either mobile or tablet. For that, under the lib folder lib/utils/setup/responsive_ui_setup/enums, we create new enum called device_screen_type.
3. responsive_builder: For this class we use a layoutBuilder widget. This widget provides us with a builder that also gives us BoxConstraints, in our case this widget return an object of type sizingInformation. In fact, this object has four required attributes:
  * orientation of type Orientation.
  * deviceType of type DeviceScreenType our enum class.
  * screenSize and localWidgetSize of type Size.
  
4. screen_type_layout: This widget search for building a Widget per Screen Type, so it returns our responsiveBuilder widget for either mobile or tablet screen.

## DartDoc

The dartdoc command creates API reference documentation from Dart source code. 
You can add descriptions to the generated documentation by using documentation comments, which can contain markdown formatting. For guidance on writing doc comments.
[dartdoc Help](https://dart.dev/guides/language/effective-dart/documentation)
 ```
$ pub global activate dartdoc
$ flutter pub global run dartdoc:dartdoc
```

## Crashlytics

To add Firebase Crashlytics you should:

### iOS:
1. add the googleService-Info.plist to ios/ folder.
2. From Xcode select Runner from the project navigation.
3. Select the Build Phases tab.
4. Click + Add a new build phase, and select New Run Script Phase.
5. Add ${PODS_ROOT}/Fabric/run to the Type a script... text box.

### Android:
1. add the google-services.json to android/app folder.
2. add these lines to android/build.gradle in dependencies :
    ```
    classpath 'com.google.gms:google-services:4.3.3'
    classpath 'com.google.firebase:firebase-crashlytics-gradle:2.1.1'
    ```
   
3. add these lines to android/app/build.gradle :

    ```
    apply plugin: 'com.google.gms.google-services'
    apply plugin: 'com.google.firebase.crashlytics'
    ```

    in buildTypes:
    ```
    firebaseCrashlytics {
        nativeSymbolUploadEnabled true
    }
    ```
    in dependencies:
    ```
    implementation 'com.google.firebase:firebase-crashlytics:17.0.0'
    implementation 'com.google.firebase:firebase-analytics:17.4.2'
    ```

### Flutter code:

in pubspec.yaml:
```yaml
firebase_crashlytics: ^0.1.3+3
```

in main.dart
```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  setupLocator();

  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZonedGuarded(() {
    runApp(MyApp());
  }, Crashlytics.instance.recordError);
}
```







**Notes:** 

- You should consider using Webp assets  instead of Png assets because it's smaller in size and still providing transparency and the same quality. [Png Vs Webp](https://insanelab.com/blog/web-development/webp-web-design-vs-jpeg-gif-png/)
