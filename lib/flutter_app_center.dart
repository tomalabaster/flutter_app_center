import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAppCenter {
  static const MethodChannel _channel =
      const MethodChannel('flutter_app_center');

  static Future<void> start(String secret, List<String> services) =>
      _channel.invokeMethod('start', {'secret': secret, 'services': services});

  static Future<void> setLogLevel([int logLevel = 99]) =>
      _channel.invokeMethod('setLogLevel', {'logLevel': logLevel});

  static Future<String> get installId => _channel.invokeMethod('installId');

  static Future<void> setUserId(String userId) =>
      _channel.invokeMethod('setUserId', {'userId': userId});

  static Future<void> setEnabled(bool enabled) =>
      _channel.invokeMethod('setEnabled', {'enabled': enabled});

  static Future<bool> get isEnabled => _channel.invokeMethod('isEnabled');

  static Future<String> get sdkVersion => _channel.invokeMethod('sdkVersion');
}
