# Masterlogin
An example of an app with Authentication on Flutter, using Auth0.

Masterlogin contains platform-specific elements for Android and iOS.

# Installation and Usage
1. Follow the installation instructions on www.flutter.io to install Flutter.
2. You'll need to create an Auth0 account. Follow the instructions at https://manage.auth0.com.
3. Once your Auth0 account is created, you'll need to get Client ID and Domain.
  - Create a new client application in your Auth0 dashboard. For Type, select Native.
  - Go to the Settings section and get your Client ID and Domain
4. Configure Callback URLs
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

5. Clone this repository

6. Set Credentials

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

7. Install Auth0 dependency

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

8. MasterLogin can be run like any other Flutter app, either through the IntelliJ UI or
 through running the following command from within the masterlogin directory:

```
flutter run
```

