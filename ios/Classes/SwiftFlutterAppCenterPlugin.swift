import AppCenter
import Flutter
import UIKit

public class SwiftFlutterAppCenterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_center", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppCenterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? Dictionary<String, Any>
    
    if ("start" == call.method) {
        let secret = args?["secret"] as? String
        let services = NSMutableArray.init()
        
        for service in (args?["services"] as! NSArray) {
            services.add(NSClassFromString(service as! String)!)
        }
        
        MSAppCenter.start(secret, withServices: services as? [AnyClass])
    } else if ("setLogLevel" == call.method) {
        let rawValue = args?["logLevel"] as? UInt ?? 0
        MSAppCenter.setLogLevel(MSLogLevel.init(rawValue: rawValue)!)
        result(nil)
    } else if ("installId" == call.method) {
        result(MSAppCenter.installId()?.uuidString)
    } else if ("setUserId" == call.method) {
        let userId = args?["userId"] as? String
        MSAppCenter.setUserId(userId)
        result(nil)
    } else if ("setEnabled" == call.method) {
        let enabled = args?["enabled"] as? Bool ?? false
        MSAppCenter.setEnabled(enabled)
        result(nil)
    } else if ("isEnabled" == call.method) {
        result(MSAppCenter.isEnabled())
    } else if ("sdkVersion" == call.method) {
        result(MSAppCenter.sdkVersion())
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}
