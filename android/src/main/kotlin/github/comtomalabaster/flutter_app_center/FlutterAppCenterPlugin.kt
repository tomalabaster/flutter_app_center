package github.comtomalabaster.flutter_app_center

import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.AppCenterService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*


class FlutterAppCenterPlugin(registrar: Registrar) : MethodCallHandler {
  private var registrar: Registrar? = registrar

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_app_center")
      channel.setMethodCallHandler(FlutterAppCenterPlugin(registrar))

      FlutterAppCenterAnalyticsPlugin.registerWith(registrar)
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    val app = this.registrar?.activity()?.getApplication()
    val args = call.arguments as? HashMap<*, *>

    when {
        "start" == call.method -> {
          val secret = args?.get("secret") as String
          val services = args["services"] as ArrayList<*>
          val servicesClasses = ArrayList<Class<*>>()

          for (name in services) {
            try {
              val c = Class.forName(name as String)
              servicesClasses.add(c)
            } catch (notFound: ClassNotFoundException) {
              print(notFound.exception.toString())
            }
          }

          var servicesClassesArray = arrayOfNulls<Class<out AppCenterService>>(servicesClasses.size)
          servicesClassesArray = servicesClasses.toArray(servicesClassesArray)
          AppCenter.start(app, secret, *servicesClassesArray)
          result.success(null)
        }
        "setLogLevel" == call.method -> {
          val rawValue = args?.get("logLevel") as Int
          AppCenter.setLogLevel(rawValue)
          result.success(null)
        }
        "installId" == call.method -> AppCenter.getInstallId().thenAccept {
          result.success(it.toString())
        }
        "setUserId" == call.method -> {
          val userId = args?.get("userId") as? String
          AppCenter.setUserId(userId)
          result.success(null)
        }
        "setEnabled" == call.method -> {
          val enabled = args?.get("enabled") as? Boolean
            if (enabled != null) {
                AppCenter.setEnabled(enabled)
            }
          result.success(null)
        }
        "isEnabled" == call.method -> AppCenter.isEnabled().thenAccept {
          result.success(it)
        }
        "sdkVersion" == call.method -> result.success(AppCenter.getSdkVersion())
        else -> result.notImplemented()
    }
  }
}
