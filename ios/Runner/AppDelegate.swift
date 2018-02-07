import UIKit
import Flutter
import Auth0


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
        let batteryChannel = FlutterMethodChannel.init(name: "masterlogin/login",
                                                       binaryMessenger: controller);
        batteryChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // Handle battery messages.
        });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
      return Auth0.resumeAuth(url, options: options)
  }

  private func login(result: FlutterResult) {




    let device = UIDevice.current;
    device.isBatteryMonitoringEnabled = true;
    if (device.batteryState == UIDeviceBatteryState.unknown) {
      result(FlutterError.init(code: "UNAVAILABLE",
                               message: "Battery info unavailable",
                               details: nil));
    } else {
      result(Int(device.batteryLevel * 100));
    }
  }

}
