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
{PRODUCT_BUNDLE_IDENTIFIER}://{DOMAIN}/{PRODUCT_BUNDLE_IDENTIFIER}/callback
```
Remember to replace PRODUCT_BUNDLE_IDENTIFIER with your actual application's bundle identifier name and DOMAIN with your domain.

   **Android Callback**
```
http://{DOMAIN}/android/{YOUR_APP_PACKAGE_NAME}/callback
```
Remember to replace YOUR_APP_PACKAGE_NAME with your actual application's package name and DOMAIN with your domain.

6. Set Credentials in the project you cloned before at step 2.

  You need to set credentials for each platform you are supporting.
    
   **iOS**
    
Add your credentials in the Auth0.plist file:
 ```
<!-- Auth0.plist -->

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>ClientId</key>
  <string>{CLIENT_ID}</string>
  <key>Domain</key>
  <string>{DOMAIN}</string>
</dict>
</plist>
 ```

  **Android**
  
Edit your res/values/strings.xml file as follows:
  ```
 <resources>
     <string name="com_auth0_client_id">{CLIENT_ID}</string>
     <string name="com_auth0_domain">{DOMAIN}</string>
 </resources>
  ```

 Replace CLIENT_ID with your actual client's id and DOMAIN with your domain.

7. Install Auth0 dependency to the project 

You need to install Auth0 dependency for each platform your are supporting.

 **iOS**
 
 **- Carthage**
 
If you are using Carthage, add the following to your Cartfile:

```
   github "auth0/Auth0.swift" ~> 1.0
```
 Then, run carthage bootstrap.

 **- Cocoapods**
 
If you are using Cocoapods, add the following to your Podfile:

```
    use_frameworks!
    pod 'Auth0', '~> 1.0'
```
Then, run pod install.

 **Android**

This step is already done for you in the build.gradle file of the Android application.

8. Configure Firebase 

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

9. MasterLogin can be run like any other Flutter app, either through IntelliJ, Android Studio, Visual Studio Code or through running the following command from within the masterlogin directory:

```
flutter run
```

