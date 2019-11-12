package github.comtomalabaster.flutter_app_center

import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.AppCenterService
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*
import kotlin.collections.HashMap


class FlutterAppCenterCrashesPlugin(registrar: Registrar) : MethodCallHandler {
  private var registrar: Registrar? = registrar

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_app_center/crashes")
      channel.setMethodCallHandler(FlutterAppCenterCrashesPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    val args = call.arguments as? HashMap<*, *>
    
    when {
        "generateTestCrash" == call.method -> {
            Crashes.generateTestCrash()
            result.success(null)
        }
        "hasReceivedMemoryWarningInLastSession" == call.method -> {
            Crashes.hasReceivedMemoryWarningInLastSession().thenAccept {
                result.success(it)
            }
        }
        "hasCrashedInLastSession" == call.method -> {
            Crashes.hasCrashedInLastSession().thenAccept {
                result.success(it)
            }
        }
        "lastSessionCrashReport" == call.method -> {
            Crashes.getLastSessionCrashReport().thenAccept {
                val crashReport = it

                val report = HashMap<String, Any?>()

                if(crashReport != null) {
                    report["appErrorTime"] = crashReport.appErrorTime.time
                    report["appProcessIdentifier"] = crashReport.threadName
                    report["appStartTime"] = crashReport.appStartTime.time
                    report["exceptionName"] = null
                    report["exceptionReason"] = crashReport.stackTrace
                    report["incidentIdentifier"] = crashReport.id
                    report["reporterKey"] = null

                    val device = HashMap<String, Any>()

                    device["appBuild"] = crashReport.device.appBuild
                    device["appNamespace"] = crashReport.device.appNamespace
                    device["appVersion"] = crashReport.device.appVersion
                    device["carrierCountry"] = crashReport.device.carrierCountry
                    device["carrierName"] = crashReport.device.carrierName
                    device["locale"] = crashReport.device.locale
                    device["model"] = crashReport.device.model
                    device["oemName"] = crashReport.device.oemName
                    device["osApiLevel"] = crashReport.device.osApiLevel
                    device["osBuild"] = crashReport.device.osBuild
                    device["osName"] = crashReport.device.osName
                    device["osVersion"] = crashReport.device.osVersion
                    device["screenSize"] = crashReport.device.screenSize
                    device["sdkName"] = crashReport.device.sdkName
                    device["sdkVersion"] = crashReport.device.sdkVersion
                    device["liveUpdateDeploymentKey"] = crashReport.device.liveUpdateDeploymentKey
                    device["liveUpdatePackageHash"] = crashReport.device.liveUpdatePackageHash
                    device["liveUpdateReleaseLabel"] = crashReport.device.liveUpdateReleaseLabel
                    device["wrapperRuntimeVersion"] = crashReport.device.wrapperRuntimeVersion
                    device["wrapperSdkName"] = crashReport.device.wrapperSdkName
                    device["wrapperSdkVersion"] = crashReport.device.wrapperSdkVersion

                    report["device"] = device
                }

                result.success(report)
            }
        }
        "setEnabled" == call.method -> {
            val enabled = args?.get("enabled") as? Boolean
            if (enabled != null) {
                Crashes.setEnabled(enabled)
            }
            result.success(null)
        }
        "isEnabled" == call.method -> {
            Crashes.isEnabled().thenAccept {
                result.success(it)
            }
        }
        else -> result.notImplemented()
    }
  }
}
