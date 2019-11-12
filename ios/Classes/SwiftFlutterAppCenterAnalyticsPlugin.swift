import AppCenterAnalytics
import Flutter
import UIKit

public class SwiftFlutterAppCenterAnalyticsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_center/analytics", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppCenterAnalyticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? Dictionary<String, Any>
        
    if ("trackEvent" == call.method) {
        MSAnalytics.trackEvent(args?["eventName"] as! String, withProperties: args?["properties"] as? [String : String])
        result(nil)
    } else if ("setEnabled" == call.method) {
        let enabled = args?["enabled"] as? Bool ?? false
        MSAnalytics.setEnabled(enabled)
        result(nil)
    } else if ("isEnabled" == call.method) {
        result(MSAnalytics.isEnabled())
    } else if ("pause" == call.method) {
        MSAnalytics.pause()
        result(nil)
    } else if ("resume" == call.method) {
        MSAnalytics.resume()
        result(nil)
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}
