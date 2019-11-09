import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterAppCenterAnalytics {
  static const MethodChannel _channel =
      const MethodChannel('flutter_app_center/analytics');

  static String get id => (defaultTargetPlatform == TargetPlatform.iOS)
      ? "MSAnalytics"
      : "com.microsoft.appcenter.analytics.Analytics";

  static Future<void> trackEvent(String eventName,
          [Map<String, dynamic> properties]) =>
      _channel.invokeMethod('trackEvent', <String, dynamic>{
        'eventName': eventName,
        'properties': properties.map((k, v) => MapEntry(k, v.toString())) ?? {}
      });

  static Future<void> setEnabled(bool enabled) =>
      _channel.invokeMethod('setEnabled', {'enabled': enabled});

  static Future<bool> get isEnabled => _channel.invokeMethod('isEnabled');

  static Future<void> pause() => _channel.invokeMethod('pause');

  static Future<void> resume() => _channel.invokeMethod('resume');
}
