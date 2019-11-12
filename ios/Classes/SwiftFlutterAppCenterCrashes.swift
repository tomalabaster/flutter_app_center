import AppCenterCrashes
import Flutter
import UIKit

public class SwiftFlutterAppCenterCrashesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_center/crashes", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppCenterCrashesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? Dictionary<String, Any>
        
    if ("generateTestCrash" == call.method) {
        MSCrashes.generateTestCrash()
        result(nil)
    } else if ("hasReceivedMemoryWarningInLastSession" == call.method) {
        result(MSCrashes.hasReceivedMemoryWarningInLastSession())
    } else if ("hasCrashedInLastSession" == call.method) {
        result(MSCrashes.hasCrashedInLastSession())
    } else if ("lastSessionCrashReport" == call.method) {
        let crashReport = MSCrashes.lastSessionCrashReport()
        
        var report: Dictionary<String, Any> = Dictionary<String, Any>()
        
        if (crashReport != nil) {
            report["appErrorTime"] = Int64(((crashReport?.appErrorTime.timeIntervalSince1970)! * 1000.0).rounded())
            report["appProcessIdentifier"] = crashReport?.appProcessIdentifier
            report["appStartTime"] = Int64(((crashReport?.appStartTime.timeIntervalSince1970)! * 1000.0).rounded())
            report["exceptionName"] = crashReport?.exceptionName
            report["exceptionReason"] = crashReport?.exceptionReason
            report["incidentIdentifier"] = crashReport?.incidentIdentifier
            report["reporterKey"] = crashReport?.reporterKey
            
            var device = Dictionary<String, Any>()
            
            device["appBuild"] = crashReport?.device.appBuild
            device["appNamespace"] = crashReport?.device.appNamespace
            device["appVersion"] = crashReport?.device.appVersion
            device["carrierCountry"] = crashReport?.device.carrierCountry
            device["carrierName"] = crashReport?.device.carrierName
            device["locale"] = crashReport?.device.locale
            device["model"] = crashReport?.device.model
            device["oemName"] = crashReport?.device.oemName
            device["osApiLevel"] = crashReport?.device.osApiLevel
            device["osBuild"] = crashReport?.device.osBuild
            device["osName"] = crashReport?.device.osName
            device["osVersion"] = crashReport?.device.osVersion
            device["screenSize"] = crashReport?.device.screenSize
            device["sdkName"] = crashReport?.device.sdkName
            device["sdkVersion"] = crashReport?.device.sdkVersion
            device["liveUpdateDeploymentKey"] = crashReport?.device.liveUpdateDeploymentKey
            device["liveUpdatePackageHash"] = crashReport?.device.liveUpdatePackageHash
            device["liveUpdateReleaseLabel"] = crashReport?.device.liveUpdateReleaseLabel
            device["wrapperRuntimeVersion"] = crashReport?.device.wrapperRuntimeVersion
            device["wrapperSdkName"] = crashReport?.device.wrapperSdkName
            device["wrapperSdkVersion"] = crashReport?.device.wrapperSdkVersion
            
            report["device"] = device
        }
        
        result(report)
    } else if ("setEnabled" == call.method) {
        let enabled = args?["enabled"] as? Bool ?? false
        MSCrashes.setEnabled(enabled)
        result(nil)
    } else if ("isEnabled" == call.method) {
        result(MSCrashes.isEnabled())
    } else if ("disableMachExceptionHandler" == call.method) {
        MSCrashes.disableMachExceptionHandler()
        result(nil)
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}
