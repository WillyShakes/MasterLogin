# Masterlogin
An example of an app with Authentication on Flutter, using Auth0.

Masterlogin contains platform-specific elements for Android and iOS.

# Installation and Usage
1. Follow the installation instructions on https://flutter.io/get-started/install/ to install Flutter.
    * System requirements
        * Operating System of 64 bit (Windows, MacOs, Linux)
        * Disk Space: Windows - 400 MB, MacOs - 700 MB, Linux - 600 MB
        * Tools: Windows (git), MacOs-Linux (bash, mkdir, rm, git, curl, unzip, which)
    * Get the Flutter SDK
To get Flutter, use git to clone this [repository](https://github.com/flutter/flutter) and then add the flutter tool (path\to\flutter\bin) to your computer path.
    * run "flutter doctor" on command prompt or POWER SHELL.
    Running flutter doctor shows any remaining dependencies you may need to install.
    * iOS setup
        - Install Xcode
        - Set up the iOS simulator
        - if you want to deploy to iOs devices you need to intall these dependencies:
    homebrew, libimobiledevice, ideviceinstaller, ios-deploy, cocoapods
    * Android setup 
        - Install Android Studio, IntelliJ or Visual Studio Code
        - Dependencies: Flutter and Dart plugins (Android Studio, IntelliJ) - dart code Extension (Visual Studio Code)
        - Set up your Android device or emulator
2. Clone this repository 
3. You'll need to create an Auth0 account. Follow the instructions at https://manage.auth0.com.
4. Once your Auth0 account is created, you'll need to get Client ID and Domain.
    - Create a new client application in your Auth0 dashboard. For Type, select Native.
    - Go to the Settings section and get your Client ID and Domain
5. Configure Callback URLs
  Go to your Client's Dashboard Settings and make sure that Allowed Callback URLs contains the
  following for each platform you are supporting.

    **iOS Callback**
```
http://localhost:8585
```
Remember to replace PRODUCT_BUNDLE_IDENTIFIER with your actual application's bundle identifier name and DOMAIN with your domain.

   **Android Callback**
```
http://localhost:8585
```
 

6. Configure Firebase 

You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.

**Android**

Create an app within your Firebase instance for Android, with package name com.example.masterlogin

Run the following command to get your signing certificate SHA-1:

```
keytool -exportcert -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
```

In the Firebase console, in the settings of your Android app, add your signing certificate SHA-1.
Follow instructions to download google-services.json and place it into \masterlogin\android\app.

**Ios**

Create an app within your Firebase instance for iOS, with bundle ID io.flutter.flutter.app
Follow instructions to download GoogleService-Info.plist, and place it into  \masterlogin\ios\Runner in XCode.

Open a terminal window and navigate to the location of the Xcode project for your app.
Create a Podfile if you don't have one:
```
pod init
```
Open your Podfile and add:
```
pod 'Firebase/Core'
```
Save the file and run:
```
pod install
```

7. MasterLogin can be run like any other Flutter app, either through IntelliJ, Android Studio, Visual Studio Code or through running the following command from within the masterlogin directory:

```
flutter run
```

