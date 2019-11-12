package github.comtomalabaster.flutter_app_center

import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.AppCenterService
import com.microsoft.appcenter.analytics.Analytics
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*
import kotlin.collections.HashMap


class FlutterAppCenterAnalyticsPlugin(registrar: Registrar) : MethodCallHandler {
  private var registrar: Registrar? = registrar

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_app_center/analytics")
      channel.setMethodCallHandler(FlutterAppCenterAnalyticsPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    val args = call.arguments as? HashMap<*, *>
    
    when {
        "trackEvent" == call.method -> {
            @Suppress("UNCHECKED_CAST")
            val properties = args?.get("properties") as? Map<String, String>
            Analytics.trackEvent(args?.get("eventName") as? String, properties)
            result.success(null)
        }
        "setEnabled" == call.method -> {
            val enabled = args?.get("enabled") as? Boolean
            if (enabled != null) {
                Analytics.setEnabled(enabled)
            }
            result.success(null)
        }
        "isEnabled" == call.method -> {
            Analytics.isEnabled().thenAccept {
                result.success(it)
            }
        }
        "pause" == call.method -> {
            Analytics.pause()
            result.success(null)
        }
        "resume" == call.method -> {
            Analytics.resume()
            result.success(null)
        } 
        else -> result.notImplemented()
    }
  }
}
